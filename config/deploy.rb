set :application, "sayho"
set :repository,  "git@github.com:muik/sayho.git"
set :deploy_to, "/home/muik/deploy/#{application}"
set :rails_env, "production"
set :use_sudo, false
set :rvm_type, :user

set :scm, :git

role :web, "muik.net"                          # Your HTTP server, Apache/etc
role :app, "muik.net"                          # This may be the same as your `Web` server
role :db,  "muik.net", :primary => true # This is where Rails migrations will run

require "rvm/capistrano"
require "bundler/capistrano"
require 'capistrano-unicorn'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

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
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "ln -sf #{deploy_to}/#{shared_dir}/set_env.rb #{current_release}/config/", {:roles => :app}
  end
end
