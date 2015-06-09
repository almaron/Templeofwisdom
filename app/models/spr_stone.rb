class SprStone < SprPage
  serializable_attributes :structure, :look, :place, :magic, :healing, :life, :other

  validates_uniqueness_of :name
end