class Page < ActiveRecord::Base
  has_ancestry

  PARTIALS = [
    {
      tag: 'list_subs',
      partial: 'list_subs'
    }
  ]
  def listed_children
    self.children.where(hide_menu: 0, published: 1).order(:sort_order)
  end

  def deplete!
    self.children.each {|page| page.update(parent_id: parent_id)}
    destroy
  end

  def render_content
    text = self.content
    PARTIALS.each { |part| text.gsub! "[[#{part[:tag]}]]", "<%= render partial: '#{part[:partial]}', locals: {page: @page} %>" }
    text
  end
end
