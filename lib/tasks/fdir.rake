require 'csv'

namespace :fdir do
  desc 'Filling the stones'
  task stones: :environment do
    file = Rails.root.join('tmp','stones.csv')
    return unless File.exist? file

    CSV.foreach(file, headers: true) do |row|
      spr = SprStone.create({
        name: row['name'],
        slug: row['logo'],
        remote_image_url: "http://templeofwisdom.ru/assets/images/stones/#{row['logo']}.jpg",
        look: row['view'],
        place: row['place'],
        structure: row['struct'],
        magic: row['magic'],
        healing: row['healing'],
        life: row['life'],
        other: row['other']
      })
      puts "#{spr.id} записан в #{spr.spr}"
    end
  end

  desc 'Filling the herbs'
  task herbs: :environment do
    file = Rails.root.join('tmp','plants.csv')
    return unless File.exist? file

    CSV.foreach(file, headers: true) do |row|
      spr = SprHerb.create({
        name: row['name'],
        slug: row['logo'].split('.')[0].downcase,
        remote_image_url: "http://templeofwisdom.ru/assets/images/plants/#{row['logo']}",
        look: row['view'],
        place: row['place'],
        names: row['names'],
        healing: row['healing'],
        life: row['life'],
        other: row['other']
      })

      puts "#{spr.id} - #{spr.name} записан в #{spr.spr}"
    end
  end
end