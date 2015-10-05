class CharGroup < ActiveRecord::Base

  def self.accessible_by(group)
    case group
      when "admin"
        self.all.to_a
      when "master"
        self.where("id != ?", 1).to_a
      else
        self.where("id IN (2,3,4)").to_a
    end
  end

end
