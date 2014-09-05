class JournalPage < ActiveRecord::Base

  belongs_to :journal
  has_many :images, class_name: JournalImage, foreign_key: :page_id, dependent: :destroy
  accepts_nested_attributes_for :images
  after_initialize :set_defaults

  default_scope ->{ order(:sort_index, :id)}

  def self.types
    %w(article blocks newbies gallery)
  end

  self.types.each do |type|
    define_method "is_#{type}?" do
      page_type == type
    end
  end

  def content_blocks
    content_text.present? ? content_text.split(separator).reject(&:blank?) : []
  end

  def content_blocks=(blocks)
    self.content_text = blocks.reject(&:blank?).join(separator)
  end

  def blocks_content
    blocks = []
    (0..([2, content_blocks.size-1,images.size-1].max)).each do |i|
      blocks << ContentBlock.new(content_blocks[i] || "", image_url(i))
    end
    blocks
  end

  def newbies
    content_line.present? ? Char.includes(:profile).where(id: content_line.split(',').map(&:to_i)) : []
  end

  def image_url(index)
    images[index] && images[index].image? ? images[index].image_url : images.build().image_url
  end

  def add_image(url)
    images.create(remote_url:url) if url.present?
  end

  def reset(new_page_type)
    self.update(content_line: "", page_type: new_page_type, content_text:"")
    self.images.destroy_all
  end

  private
  def separator
    "|&|"
  end

  def set_defaults
    self.content_text ||= ''
    self.images.build  if self.is_article? && images.empty?
    self.blocks_content if self.is_blocks?
  end

end

