# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, '/home/malk/log/cron_log.log'

every 1.day, at: '5pm' do
  runner 'Statistics::PostCount.create_date'
end

every 1.day, at: '6pm' do
  runner 'Sitemap::Sitemap.build'
end
