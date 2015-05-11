class Season < ActiveRecord::Base

  def sample
    description.split("\r\n").sample
  end
  
end
