class Role < ActiveRecord::Base

  has_many :char_roles, dependent: :destroy
  accepts_nested_attributes_for :char_roles, allow_destroy: true

  def head_url
    self.paths.split(/\r?\n/).reject {|l| l.strip.empty?}[0]
  end

  attr_accessor :comment

end
