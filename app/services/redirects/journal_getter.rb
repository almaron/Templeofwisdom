class Redirects::JournalGetter
  class << self

    def get
      File.open(file_path, 'w+t') {|file| file.puts(yaml_collection)}
    end

    private

    def yaml_collection
      journal_collection.deep_stringify_keys.to_yaml
    end

    def journal_collection
      journals = {}
      journal_batch.to_a.each do |row|
        journal = Journal.eager_load(:pages).find_by(head: row['pagetitle'])
        next unless journal
        journals[row['alias']] = {
          id: journal.id,
          pages: pages_collection(row['id'], journal)
        }
      end
      journals
    end

    def pages_collection(j_id, journal)
      pages = {}
      pages_batch(j_id).to_a.each do |page|
        p = journal.pages.select {|p| p.head == page['longtitle']}[0]
        pages[page['alias']] = p.id if p
      end
      pages
    end

    def db
      @db ||= Mysql2::Client.new host: 'old.templeofwisdom.ru', username: 'bao', password: 'malkavian', database: 'temple_forum'
    end

    def file_path
      Rails.root.join('config','journals.yml')
    end

    def journal_batch
      db.query('SELECT id, pagetitle, alias FROM temple_main.hm_site_content where parent = 113 order by id')
    end

    def pages_batch(journal)
      db.query("SELECT id, longtitle, alias FROM temple_main.hm_site_content where parent = #{journal} order by id")
    end
  end
end
