class SprHerb < SprPage
  serializable_attributes :look, :place, :names, :healing, :life, :other

  validates_uniqueness_of :name
end