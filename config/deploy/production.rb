set :branch, 'master'

server '198.211.107.171', user: 'malk', roles: %w{web app db}, primary: true

set :nginx_server_name, 'templeofwisdom.ru'

set :deploy_to, "/home/malk/rails/temple_production"
