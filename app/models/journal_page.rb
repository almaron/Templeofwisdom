class JournalPage < ActiveRecord::Base

  belongs_to :journal
  has_many :images, class_name: JournalImage, foreign_key: :page_id

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

  def get_blocks_content
    blocks = []
    content_blocks.each_with_index do |block, index |
      blocks << {content: block, image:image_url(index)}
    end
    blocks
  end

  def newbies
    content_line.present? ? Char.includes(:profile).where(id: content_line.split(',').map(&:to_i)) : []
  end

  def image_url(index)
    images[index] && images[index].image? ? images[index].image_url : nil
  end

  def add_image(url)
    images.create(remote_url:url) if url.present?
  end

  private
  def separator
    "|&|"
  end

end
