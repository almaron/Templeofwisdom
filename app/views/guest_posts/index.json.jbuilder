json.array!(@guest_posts) do |guest_post|
  json.extract! guest_post, :head, :user, :ip, :content, :answer
  json.url guest_post_url(guest_post, format: :json)
end
