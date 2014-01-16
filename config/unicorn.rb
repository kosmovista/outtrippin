root = "/home/deployer/apps/ot-zuji/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.ot-zuji.sock"
worker_processes 2
timeout 30