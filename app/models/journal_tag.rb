#encoding utf-8
class JournalTag < ActiveRecord::Base

  has_many :journal_page_tags, foreign_key: :tag_id, dependent: :destroy
  has_many :pages, through: :journal_page_tags, class_name: JournalPage

  validates_uniqueness_of :name

  def self.tokens(query)
    tags = where("name like ?", "%#{query.mb_chars.downcase.to_s}%")
    if tags.empty?
      [{id: "<<<#{query.mb_chars.downcase.to_s}>>>", name: "Создать: \"#{query.mb_chars.downcase.to_s}\""}]
    else
      tags.to_a
    end
  end

  def self.ids_from_tokens(tokens)
    Rails.logger.info tokens
    tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
    tokens.split(',')
  end


end
