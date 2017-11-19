require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'

set :application_name, 'delivery'
set :domain, '159.89.6.131'
set :deploy_to, '/srv/app'
set :repository, 'git@github.com:tilvin/delivery.git'
set :branch, 'master'
set :user, 'develop'

set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

task :environment do
  invoke :'rbenv:load'
end

task :setup do

end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{sudo systemctl stop app_puma.service}
        command %{sudo systemctl start app_puma.service}
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end
