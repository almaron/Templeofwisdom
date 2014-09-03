class JournalPage < ActiveRecord::Base

  belongs_to :journal
  has_many :images, class_name: JournalImage, foreign_key: :page_id

  def self.types
    %w(article blocks newbies gallery)
  end

  def content_blocks
    content.split('||separator||')
  end

  def content_blocks=(blocks)
    self.content = blocks.join('||separator||')
  end

  def get_blocks_content
    blocks = []
    content_blocks.each_with_index do |block, index |
      blocks << {content: block, image:image_url(index)}
    end
  end

  private

  def image_url(index)
    images[index] && images[index].image? ? images[index].image_url : nil
  end

end
