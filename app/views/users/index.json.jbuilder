if params[:short]
  json.array! @users do |user|
    json.(user, :id, :name)
  end
else
  json.array! @users, partial:"user", as: :user
end
