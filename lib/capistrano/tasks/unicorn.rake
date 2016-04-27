namespace :unicorn do

  class UnicornPIDError < StandardError; end

  def rails_env
    Rails.env
  end

  def rails_root
    Rails.root
  end

  def unicorn_pid_file
    "#{Rails.root}/shared/pids/unicorn.#{rails_env}.pid"
  end

  def unicorn_pid(quiet = false)
    error = ->(message) { raise UnicornPIDError, message unless quiet }

    if ( pid = File.read(unicorn_pid_file).strip.to_i ) <= 0
      return error.call "pid file '#{unicorn_pid_file}' does not contain a valid pid"
    end

    pid
  rescue Errno::ENOENT
    error.call "pid file '#{unicorn_pid_file}' does not exist"
  end

  def kill_unicorn(signal, pid = nil)
    Process.kill(signal, pid || unicorn_pid)
  end

  desc 'start Unicorn server daemonized (config file: config/unicorn.rb)'
  task :start => :environment do
    puts 'Starting unicorn...'
    Process.spawn *%W(bundle exec unicorn_rails -c #{rails_root}/config/unicorn/development.rb -E #{rails_env} -D)
    Process.wait
  end

  desc 'stop Unicorn server'
  task :stop, [:quiet] => :environment do |t, args|
    print 'Stopping unicorn...'
    if pid = unicorn_pid(args[:quiet])
      puts ''
      kill_unicorn('TERM', pid)
    else
      puts ' unicorn seems not to be running.'
    end
  end

  desc 'executes `rake unicorn:stop && rake unicorn:start`'
  task :restart => :environment do
    Rake::Task['unicorn:stop'].execute(quiet: true)
    Rake::Task['unicorn:start'].execute
  end

  desc 'reloads config file and gracefully restart all workers. If the "preload_app" directive '          <<
       'is false (the default), then workers will also pick up any application code changes '             <<
       'when restarted. If "preload_app" is true, then application code changes will have no effect; '    <<
       'USR2 + QUIT (see below) must be used to load newer code in this case. When reloading '            <<
       'the application, Gem.refresh will be called so updated code for your application can pick up '    <<
       'newly installed RubyGems. It is not recommended that you uninstall libraries your application '   <<
       'depends on while Unicorn is running, as respawned workers may enter a spawn loop when they fail ' <<
       'to load an uninstalled dependency.'
  task :graceful_restart => :environment do
    kill_unicorn('HUP')
  end

  desc 'graceful shutdown, waits for workers to finish their current request before finishing'
  task :graceful_shutdown => :environment do
    kill_unicorn('QUIT')
  end

  desc 'reexecute the running binary. A separate QUIT should be sent to the original process once the child is verified to be up and running'
  task :reload => :environment do
    kill_unicorn('USR2')
  end

  desc 'gracefully stops workers but keep the master running. This will only work for daemonized processes.'
  task :graceful_stop => :environment do
    kill_unicorn('WINCH')
  end

  desc 'increment the number of worker processes by one'
  task :increment_workers => :environment do
    kill_unicorn('TTIN')
  end

  desc 'decrement the number of worker processes by one'
  task :decrement_workers => :environment do
    kill_unicorn('TTOU')
  end

end