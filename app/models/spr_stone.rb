class SprStone < SprPage
  serializable_attributes :structure, :look, :place, :magic, :healing, :life, :other

  validates_uniqueness_of :name

  def main_params
    %i(structure look place)
  end

  def use_params
    %i(magic healing life)
  end
end