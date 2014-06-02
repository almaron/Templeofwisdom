json.(user, :id, :name, :email, :group)
json.profile_attributes do
  json.extract! user.profile, :full_name, :icq, :skype, :contacts, :viewcontacts
  json.show_contacts simple_format(user.profile.contacts) if user.profile.contacts
  json.birth_date I18n.l(user.profile.birth_date) if user.profile.birth_date
end