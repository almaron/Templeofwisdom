class CharRoleSkill < ActiveRecord::Base

  belongs_to :char_role
  belongs_to :skill

  def mark_done
    self.update(done:1)
  end

  def done?
    self.done > 0
  end

end
