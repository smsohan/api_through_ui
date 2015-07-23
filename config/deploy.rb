lock '3.3.5'

set :application, 'api_through_ui'
set :repo_url, 'git@github.com:smsohan/api_through_ui.git'

set :use_sudo, true

set :linked_dirs, fetch(:linked_dirs, []).push('secrets')

SSHKit.config.command_map[:build_and_run] = "#{current_path}/build_and_run.sh"

namespace :deploy do

  task :restart_all do
    on roles(:app) do
      execute :service, 'docker restart'
      execute :docker, 'start mongodb'
      execute :docker, 'start api_through'
      execute :docker, 'start api_through_ui'
    end
  end

  task :build_and_run do
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

  after :finished, :build_and_run

end
