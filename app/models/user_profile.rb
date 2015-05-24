class UserProfile < ActiveRecord::Base
  trimmed_fields :full_name, :skype, :icq, :contacts
  belongs_to :user

  # validate :birth_date_format
  #
  # def birth_date_format
  #   if @birth_date
  #     errors.add(:birth_date) unless Date.parse(@birth_date)
  #   end
  # end

end
