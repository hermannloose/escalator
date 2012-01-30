$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "escalator"
set :repository,  "https://github.com/hermannloose/escalator.git"
set :branch, "setup-capistrano"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/hermann/deployments/escalator"
set :use_sudo, false
set :rvm_type, :user

role :web, "escalator.burnandtremble.com"                          # Your HTTP server, Apache/etc
role :app, "escalator.burnandtremble.com"                          # This may be the same as your `Web` server
role :db,  "escalator.burnandtremble.com", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  desc "Start Thin."
  task :start do
    run "cd #{deploy_to}/current && bundle exec thin start -C config/thin.yml"
  end

  desc "Stop Thin."
  task :stop do
    run "cd #{deploy_to}/current && bundle exec thin stop -C config/thin.yml"
  end

  desc "Restart Thin."
  task :restart do
    run "cd #{deploy_to}/current && bundle exec thin restart -C config/thin.yml"
  end
end
