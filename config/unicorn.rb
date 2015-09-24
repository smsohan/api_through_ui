app_dir = Dir.pwd

working_directory app_dir

pid "#{app_dir}/tmp/unicorn.pid"

stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

worker_processes 1
listen "127.0.0.1:#{ENV.fetch("PORT")}", tcp_nopush: true
timeout 30