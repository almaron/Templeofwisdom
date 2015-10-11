set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

server '198.211.107.171', user: 'malk', roles: %w{web app db}, primary: true

set :nginx_server_name, 's.templeofwisdom.ru'

set :deploy_to, '/home/malk/rails/temple_stage'

set :linked_files, %w{ config/database.yml config/secrets.yml  config/settings.yml public/robots.txt config/journals.yml}
