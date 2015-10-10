set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

server '198.211.107.171', user: 'malk', roles: %w{web app db}, primary: true

set :nginx_server_name, 's.templeofwisdom.ru'

set :deploy_to, '/home/malk/rails/temple_stage'

set :linked_files, %w{ config/database.yml config/secrets.yml  config/settings.yml public/robots.txt config/journals.yml}
# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
