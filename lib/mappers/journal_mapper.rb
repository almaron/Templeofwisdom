module Mappers
  class JournalMapper
    attr_accessor :db, :journal

    def initialize(db, logger)
      @db, @logger = db, logger
    end

    def map
      journals.each do |row|
        jid = row['id']
        journal = Journal.new({
          head: row['head'],
          description: first_child(jid)['pagetitle'],
          published: true,
          remote_cover_url: journal_image_url(jid)
        })
        get_children(jid, true).each_with_index do |page|
          pid = page['id'].to_i
          jp = journal.pages.build({
            page_type: page_type(page['template']),
            head: page['longtitle'].present? ? page['longtitle'] : page['pagetitle'],
            sort_index: index
          })
          case jp.page_type
            when 'article'
              jp.content_text = sub_content(page['content'])
              jp.content_line = aticle_author(pid)
              url = article_image_url(pid)
              jp.images.build(remote_image_url: url) if url
            when 'newbies'
              jp.content_line = newbies(pid)
            when 'blocks'
              images = blocks_images pid
              blocks_content(pid).each_with_index do |part, index|
                jp.blocks.build({
                  content: sub_content(part),
                  remote_image_url: images[index]
                })
              end
            when 'gallery'
              jp.content_text = sub_content page['content']
              gallery_urls(pid).each do |url|
                jp.images.build remote_image_url: url
              end
          end
        end
        if journal.save
          puts "Journal #{journal.head} save success"
        else
          puts "Journal #{journal.head} save failed"
          logger.debug journal.errors.full_messages.join("\n")
        end
      end
    end

    private

    def journals
      get_children
    end

    def pages(id)
      get_children(id, true)
    end

    def fields
      %w( id pagetitle longtitle content publishedon template ).join(',')
    end

    def get_children(id=113, template = false)
      db.query "SELECT #{fields} FROM temple_main.hm_site_content WHERE parent = #{id} #{'AND WHERE template > 12 ' if template}ORDER BY menuindex"
    end

    def first_child(id=113)
      db.query("SELECT * FROM temple_main.hm_site_content where parent = #{id} order by menuindex LIMIT 1").first
    end

    def journal_image_url(id)
      id = first_child(id)['id']
      raw = db.query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 14;")
      raw.first.value
    end

    def newbies(id)
      raw = db.query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 15;")
      raw.first.value.split(',').map {|i| char_map.index(i.to_i)}.join(',')
    end

    def article_image_url(id)
      raw = db.query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 16")
      raw.first['value']
    end

    def aticle_author(id)
      raw = db.query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 17")
      raw.first['value']
    end

    def blocks_content(id)
      raw = db.query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid in (18,19,20) order by tmplvarid;")
      raw.to_a.map { |row| row['value'] }
    end

    def blocks_images(id)
      raw = db.query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid in (21, 22, 23) order by tmplvarid;")
      raw.to_a.map { |row| row['value'] }
    end

    def gallery_urls(id)
      raw = db.query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 28")
      raw.first['value'].split("\r\n").map { |r| r.split('|')[1]}
    end

    def sub_content(text)
      text.gsub!('<p>{{yandex_share}}</p>','')
      text.gsub!(/<strong>(.*?)<\/strong>/,'[b]\1[/b]')
      text.gsub!(/<em>(.*?)<\/em>/,'[i]\1[/i]')
      text.gsub!('<p>','').gsub!('</p>',"\n").gsub!('<br />', "\n")
      text.gsub!(/<span.*?>(.*?)<\/span>/, '[u]\1[/u]')
      text.gsub!(/<a href="(.*?)">(.*?)<\/a>/, '[url=\1]\2[/url]')
      text
    end

    def page_type(number)
      { newbies: 13, article: 14, blocks: 15, gallery: 17 }.key(number).to_s
    end

    def char_map
      @char_map ||= CharIdMapper.new.map
    end

  end
end
