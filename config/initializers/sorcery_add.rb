module Sorcery
  module Controller
    module Submodules
      # This submodule helps you login users from external auth providers such as Twitter.
      # This is the controller part which handles the http requests and tokens passed between the app and the @provider.
      module External
        module InstanceMethods

          def debug_user_hash(provider_name)
            sorcery_fetch_user_hash provider_name
            config = user_class.sorcery_config

            attrs = user_attrs(@provider.user_info_mapping, @user_hash)

            user = user_class.new(attrs)
            user.send(config.authentications_class.to_s.downcase.pluralize).build(config.provider_uid_attribute_name => @user_hash[:uid], config.provider_attribute_name => provider_name)

            session[:incomplete_user] = {
                :provider => {config.provider_uid_attribute_name => @user_hash[:uid], config.provider_attribute_name => provider_name},
                :user_hash => attrs
            } unless user.save

            @user_hash[:user_info]
          end

          def new_from(provider_name)
            sorcery_fetch_user_hash provider_name
            config = user_class.sorcery_config

            attrs = user_attrs(@provider.user_info_mapping, @user_hash)

            user = user_class.new(attrs)

            session[:incomplete_user] = {
                :provider => {config.provider_uid_attribute_name => @user_hash[:uid], config.provider_attribute_name => provider_name},
                :user_hash => attrs
            }
            user
          end

        end
      end
    end
  end
end