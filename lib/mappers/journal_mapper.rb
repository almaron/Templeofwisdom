module Mappers
  class JournalMapper
    attr_accessor :db, :logger

    def initialize(db, logger)
      @db, @logger = db, logger
    end

    def map
      journals.each do |row|
        map_journal row
      end
    end

    def map_one(id)
      raw = db.forum_query("SELECT #{fields} FROM temple_main.hm_site_content WHERE parent = 113 AND `pagetitle` LIKE '%#{id}%'")
      map_journal raw.first if raw.any?
    end

    private

    def journals
      get_children
    end

    def pages(id)
      get_children(id, true)
    end

    def map_journal(row)
      jid = row['id']
      journal = Journal.new({
                              head: row['pagetitle'],
                              description: first_child(jid)['pagetitle'],
                              published: true
                            })
      cover_url =  journal_image_url(jid)
      journal.remote_cover_url = cover_url if cover_url && image_exists?(cover_url)
      get_children(jid, true).each_with_index do |page, index|
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
            jp.images.build(remote_image_url: url) if url && image_exists?(url)
          when 'newbies'
            jp.content_line = newbies(pid)
          when 'blocks'
            images = blocks_images pid
            blocks_content(pid).each_with_index do |part, i|
              jp.blocks.build({
                                content: sub_content(part),
                                remote_image_url: image_exists?(images[i]) ? images[i] : nil
                              })
            end
          when 'gallery'
            jp.content_text = sub_content page['content']
            gallery_urls(pid).each do |url|
              jp.images.build(remote_image_url: url) if image_exists?(url)
            end
        end
        unless jp.valid?
          logger.error "page #{page['id']} - #{page['pagetitle']} invalid!!"
          logger.error jp.errors.full_messages
        end
      end
      if journal.save
        puts "Journal #{journal.head} save success"
      else
        puts "Journal #{journal.head} save failed"
        logger.debug journal.head
        logger.debug journal.errors.full_messages.join("\n")
      end
    end

    def fields
      %w( id pagetitle longtitle content publishedon template ).join(',')
    end

    def get_children(id=113, template = false)
      db.forum_query "SELECT #{fields} FROM temple_main.hm_site_content WHERE parent = #{id} #{'AND template > 12 ' if template}ORDER BY menuindex"
    end

    def first_child(id=113)
      db.forum_query("SELECT * FROM temple_main.hm_site_content where parent = #{id} order by menuindex LIMIT 1").first
    end

    def journal_image_url(id)
      id = first_child(id)['id']
      raw = db.forum_query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 14;")
      raw.first['value'] if raw.any?
    end

    def newbies(id)
      raw = db.forum_query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 15;")
      raw.first['value'].split(',').map {|i| char_map.index(i.to_i)}.join(',')
    end

    def article_image_url(id)
      raw = db.forum_query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 16")
      raw.first['value'] if raw.any?
    end

    def aticle_author(id)
      raw = db.forum_query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 17")
      raw.first['value'] if raw.any?
    end

    def blocks_content(id)
      raw = db.forum_query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid in (18,19,20) order by tmplvarid;")
      raw.to_a.map { |row| row['value'] }
    end

    def blocks_images(id)
      raw = db.forum_query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid in (21, 22, 23) order by tmplvarid;")
      raw.to_a.map { |row| row['value'] }
    end

    def gallery_urls(id)
      raw = db.forum_query("SELECT * FROM temple_main.hm_site_tmplvar_contentvalues where contentid = #{id} and tmplvarid = 28")
      raw.first['value'].split("\r\n").map { |r| r.split('|')[1]} if raw.any?
    end

    def sub_content(text)
      text = text.gsub('<p>{{yandex_share}}</p>','')
      text = text.gsub(/<p.*?>/,'').gsub('</p>',"\n\n").gsub('<br />', "\n").gsub("\r\n",'').gsub("\n",'<brrrrrr>')

      text = text.gsub(/<strong>(.*?)<\/strong>/,'[b]\1[/b]')
      text = text.gsub(/<em>(.*?)<\/em>/,'[i]\1[/i]')

      text = text.gsub(/<span.*?>(.*?)<\/span>/, '[u]\1[/u]')
      text = text.gsub(/<a href="(.*?)">(.*?)<\/a>/, '[url=\1]\2[/url]')
      text = text.gsub('&laquo;','«').gsub('&raquo;','»').gsub('&mdash;','—').gsub('&hellip;','...')
      text = text.gsub('&nbsp;',' ').gsub('&ndash;','—').gsub('&bull;','•')
      text = text.gsub(/<img.*?src="(.*?)".*?>/,'[img]\1[/img]')
      text.gsub('<brrrrrr>',"\n")
    end

    def page_type(number)
      { newbies: 13, article: 14, blocks: 15, gallery: 17 }.key(number).to_s
    end

    def image_exists?(url)
      JournalImage.new(remote_image_url: url).valid?
    end


    def char_map
      @char_map ||= CharIdMapper.new.map
    end

  end
end
