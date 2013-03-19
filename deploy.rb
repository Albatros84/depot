set :user, 'janusz'
set :domain, 'depot.books.com'
set :application, 'depot'

set :repository, "#{user}@#{domain}:git/#{application}.git"
set :deploy_to, "/home/#{user}/#{domain}"

role :app, domain
role :web, domain
role :db, domain, :primary=>true

set :deploy_via, :remote_cache
set :scm, "git"
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false

namespace :deploy do
desc "cause Passenger to initiate restart"
task :restart do
	run "touch #{current_path}/tmp/restart.txt"
end

desc "reload the database with seed data"
task :seed do
	run "cd #{current_path}; rake db:seed RAILS_ENV=production"
	end
end

	after "deploy:update_code", :bundle_install
	desc "install the necessary prerequisites"
	task :bundle_install, :roles => :app do
	run "cd #{release_path} && bundle install"
end

