class CharRoleSkill < ActiveRecord::Base

  belongs_to :char_role
  belongs_to :skill

  scope :done, ->{ where(done: 1) }
  scope :undone, ->{ where(done: 0)}

  def mark_done
    self.update(done:1)
  end

  def done?
    self.done > 0
  end

end
