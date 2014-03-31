if defined? ActionMailer::Railtie
  Rails.application.class.configure do

    if Rails.env.development?
      config.action_mailer.raise_delivery_errors = true
      config.action_mailer.delivery_method = :file

      config.action_mailer.file_settings = {
        :location => Rails.root.join('tmp/mails'),
      }
      config.action_mailer.default_url_options = {
        host: 'localhost:8080',
        only_path: false
      }
    end

    if Rails.env.production? or Rails.env.staging?
      config.action_mailer.raise_delivery_errors = true
      config.action_mailer.delivery_method = :smtp
      # config.action_mailer.default_url_options = {
      #   host: 'webjet.com.au',
      #   only_path: false
      # }
    end
  end

  ActionMailer::Base.smtp_settings = {
    :address => 'mail.webjet.com.au',
    :domain => 'webjet',
    :user_name => 'Zujiauplanmytrip',
    :password => 'I will call you with this',
  }
end