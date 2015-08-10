namespace :fetch do
  db_params = { host: '104.131.201.9', username: 'bao', password: 'malkavian', reconnect: true }
  main_db = -> { Mysql2::Client.new db_params.merge database: 'temple_main' }
  forum_db = -> { Mysql2::Client.new db_params.merge database: 'temple_forum' }


  desc 'Fetching users from old database'
  task chars: :environment do
    logger = Logger.new 'log/char_mapping.log'
    Mappers::CharMapper.new(main_db.call, logger).map
  end

  desc 'Fetching forum topics & posts'
  task forum: :environment do
    logger = Logger.new 'log/forum_mapping.log'
    Mappers::TopicMapper.new(forum_db.call, logger).map
  end

  desc 'Fetching char roles'
  task :roles do

  end
end
