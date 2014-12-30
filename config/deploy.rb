lock '3.3.5'

set :application, 'api_through_ui'
set :repo_url, 'git@github.com:smsohan/api_through_ui.git'

set :linked_dirs, fetch(:linked_dirs, []).push('secrets')

SSHKit.config.command_map[:build_and_run] = "#{current_path}/build_and_run.sh"

namespace :deploy do

  task :build_and_run do
    on roles(:app) do

      within current_path do
        secret_key_base = capture('cat', 'secrets/SECRET_KEY_BASE').strip

        with SECRET_KEY_BASE: secret_key_base do
          execute :build_and_run
        end
      end
    end
  end

  after :finished, :build_and_run

end
