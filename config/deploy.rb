lock '3.3.5'

set :application, 'api_through_ui'
set :repo_url, 'https://github.com/smsohan/api_through_ui.git'

set :use_sudo, true

set :linked_files, fetch(:linked_files, []).push(".env.production")
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

SSHKit.config.command_map[:build_and_run] = "#{current_path}/build_and_run.sh"

set :use_docker, fetch(:use_docker, true)

set :rbenv_ruby, "2.2.2"
set :rbenv_type, :system
set :rails_env, "production"
set :assets_roles, :app

set :pty, true

Rake::Task['deploy:log_revision'].clear_actions

module SSHKit
  class Command
    def user(&block)
      "sudo -E -u root #{environment_string + " " unless environment_string.empty?}-- sh -c '%s'" % %Q{#{yield}}
    end
  end
end

namespace :deploy do

  task :restart_all do
    on roles(:app) do
      execute :service, 'docker restart'
      execute :docker, 'start mongodb'
      execute :docker, 'start api_through'
      execute :docker, 'start api_through_ui'
    end
  end

  task :docker do
    on roles(:app) do

      last_gemfile_lock = nil
      last_release_dir = nil

      puts "release_path = #{releases_path}"

      within releases_path do
        last_release = capture('ls', '-al | tail -2 | head -1')
        if last_release
          last_release_dir = last_release.strip.split.last
          last_gemfile_lock = begin; capture('sha256sum', last_release_dir + '/Gemfile.lock').strip.split.first; rescue ''; end
        end
      end

      within current_path do

        if last_gemfile_lock
          current_gemfile_lock = capture('sha256sum', 'Gemfile.lock').strip.split.first
          if current_gemfile_lock == last_gemfile_lock
            puts "Copying the old Gemfile* since the contents are same"
            execute :cp, "--preserve=timestamps #{releases_path}/#{last_release_dir}/Gemfile*", "."
          else
            puts "Skipping the Gemfile.lock copy since the shas are different"
          end
        else
          puts "Last release Gemfile.lock is not found"
        end

        secret_key_base = capture('cat', 'secrets/SECRET_KEY_BASE').strip
        devise_secret = capture('cat', 'secrets/DEVISE_SECRET').strip

        with SECRET_KEY_BASE: secret_key_base, PRODUCTION_HOST: fetch(:host), DEVISE_SECRET: devise_secret do
          execute :build_and_run
        end
      end
    end
  end

  task :standalone do
    on roles(:app) do
      within current_path do
        invoke 'deploy:compile_assets'

        as :root do
          with path: "/bin:/usr/bin:/usr/local/bin" do
            execute :svc, '-t /service/unicorn'
          end
        end
      end
    end
  end

  task :restart do
    if fetch(:use_docker)
      invoke 'deploy:docker'
    else
      invoke 'deploy:standalone'
    end
  end

  task :cleanup_git_ssh do
    on roles(:app) do
      execute :rm, fetch(:git_environmental_variables)[:git_ssh]
    end
  end

  after :published, 'deploy:cleanup_git_ssh'
  after :finished, 'deploy:restart'
  after :failed, 'deploy:cleanup_git_ssh'

end

