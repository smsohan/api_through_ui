role :app, "#{ENV['SSH_USER']}@#{ENV['HOST']}"

set :host, 'spyrest.com'
set :use_docker, false