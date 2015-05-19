class JournalTag < ActiveRecord::Base

  has_many :journal_page_tags, foreign_key: :tag_id, dependent: :destroy
  has_many :pages, through: :journal_page_tags, class_name: JournalPage

  def self.tokens(query)
    tags = where("name like ?", "%#{query}%")
    if tags.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      tags.to_a
    end
  end

  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end

end
