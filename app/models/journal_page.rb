class JournalPage < ActiveRecord::Base

  belongs_to :journal
  has_many :images, class_name: JournalImage, foreign_key: :page_id, dependent: :destroy
  accepts_nested_attributes_for :images

  has_many :blocks, class_name: JournalBlock, foreign_key: :page_id, dependent: :destroy
  accepts_nested_attributes_for :blocks

  after_initialize :set_defaults

  has_many :journal_page_tags, foreign_key: :page_id, dependent: :destroy
  has_many :tags, class_name: JournalTag, through: :journal_page_tags

  default_scope ->{ order(:sort_index, :id)}

  def self.types
    %w(article blocks newbies gallery)
  end

  self.types.each do |type|
    define_method "is_#{type}?" do
      page_type == type
    end
  end

  def tag_tokens=(tokens)
    self.tag_ids = JournalTag.ids_from_tokens(tokens)
  end

  def tag_tokens
    tags.to_a
  end

  def newbies
    content_line.present? ? Char.includes(:profile).where(id: content_line.split(',').map(&:to_i)) : []
  end

  def add_image(url)
    images.create(remote_url:url) if url.present?
  end

  def reset(new_page_type)
    self.update(content_line: "", page_type: new_page_type, content_text:"")
    self.images.destroy_all
    self.blocks.destroy_all
  end

  def image_url(index)
    images[index].image_url if images[index]
  end

  def set_defaults(hit=false)
    self.content_text ||= ''
    self.images.build  if hit && self.is_article? && images.empty?
    3.times { self.blocks.build } if hit && self.is_blocks? && blocks.empty?
  end

  private


end

