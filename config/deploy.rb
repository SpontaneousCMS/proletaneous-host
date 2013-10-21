ENV["SPOT_MODE"] = "console"

default_run_options[:pty]   = true
# run capistrano in a login shell so that ruby version managers can do their thing
# otherwise it's just a constant problem trying to use the installed/configured
# version of ruby
default_run_options[:shell] = '/bin/bash -l'


ssh_options[:port]          = 22
ssh_options[:forward_agent] = true

set :ruby_version,          "2.0.0-p247"

set :domain,                "proletaneous.spontaneous.io"
set :cms,                   "edit.proletaneous.spontaneous.io"
set :application,           "proletaneous.spontaneous.io"
server                      "162.243.59.62", :app, :web, :db, :media
set :user,                  "pro"
set :use_sudo,              false


set :scm,                   "git"
set :repository,            "git@github.com:SpontaneousCMS/proletaneous-host.git"

set :deploy_to,             "/home/#{fetch(:user)}/spontaneous"

# server provisioning configuration

set :production_env_file,   ".env.production"
set :server_memory_mb,      512
# set :nginx_opts,            { auth: { domain: "Action 2020", user: "action", password: "2222" } }

namespace :deploy do
  task :restart, :roles => [:app, :web] do
    run "sv kill /home/#{fetch(:user)}/service/enabled/back"
  end
end
