class SprPage < ActiveRecord::Base
  include SerializableAttributes

  self.inheritance_column = :spr

  serialize :attrs, Hash

  mount_uploader :image, SprPageUploader

  def group
    name.mb_capitalize[0]
  end

  def to_param
    slug
  end

  def self.find_by_param(slug)
    unless find_by(slug: slug)
      raise ActiveRecord::RecordNotFound
    end
  end
end