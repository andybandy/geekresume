require 'rvm/capistrano'
require 'bundler/capistrano'

set :repository, "git@github.com:keydunov/geekresume.git"
set :application,  "geekresume"

set :deploy_via, :remote_cache
set :deploy_to, "/home/geekresume/www"
set :user, 'geekresume'
set :scm, :git
set :rails_env, "production"
set :keep_releases, 1
set :rvm_ruby_string, '2.0.0'
set :use_sudo, false
set :normalize_asset_timestamps, false

default_run_options[:pty]

role :app, "178.79.182.69"                          # This may be the same as your `Web` server
role :db,  "178.79.182.69", :primary => true        # This is where Rails migrations will run

before 'deploy:setup', 'rvm:install_rvm'  # install RVM
before 'deploy:setup', 'rvm:install_ruby' # install Ruby and create gemset

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# Запустить вспомогательные задачи
task :release_prepare_app, :roles => :app do
  run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
  run "ln -s #{shared_path}/settings.yml #{release_path}/config/settings.yml"

  run "cd #{release_path} && bundle install"
  run "cd #{release_path} && RAILS_ENV=production bundle exec rake assets:precompile"
end
task :release_prepare_db, :roles => :db do
  run "cd #{release_path} && RAILS_ENV=production bundle exec rake db:create db:migrate"
end
before "deploy:create_symlink", "release_prepare_app"
before "deploy:create_symlink", "release_prepare_db"

namespace :deploy do
  desc "Start server"
  task :start, :roles => :app do
    run "cd #{current_path} && bundle exec rails server -d -e production"
  end

  desc "Stop server"
  task :stop, :roles => :app do
    run "kill -9 `cat #{current_path}/tmp/pids/server.pid`; true"
  end

  desc "Restart server"
  task :restart, :roles => :app do
    stop
    sleep 3
    start
  end
end
