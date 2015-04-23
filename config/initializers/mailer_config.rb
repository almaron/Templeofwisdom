Rails.application.configure do
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'templeofwisdom.ru',
      user_name:            'noreply@templeofwisdom.ru',
      password:             'yw6V1mjUegXQXqarm42',
      authentication:       'plain',
      enable_starttls_auto: true
    }
end