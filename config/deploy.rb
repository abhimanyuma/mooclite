# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'my_app_name'
set :repo_url, 'git@bitbucket.org:abhimanyuma/mooclite.git'

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '1.9.3-p551'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :application, "mooclite"
set :user, "ubuntu"
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :use_sudo, false

set :branch, "master"

desc 'Install bower'
namespace :bower do
  task :install do
    on roles(:all) do
      within release_path do
        execute :rake, 'bower:install'
      end
    end
  end
end
before "deploy:updated", "bower:install" # keep only the last 5 releases

