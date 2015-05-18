FactoryGirl.define do
  factory :char_avatar do
    char_id 1
    remote_image_url 'https://pbs.twimg.com/profile_images/469778545066000384/1KXb73mW_normal.jpeg'
    default false

    factory :default_avatar do
      default true
    end
  end
end
