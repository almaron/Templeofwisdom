class Page < ActiveRecord::Base
  has_ancestry

  def deplete!
    self.children.each {|page| page.update(parent_id: parent_id)}
    destroy
  end
end
