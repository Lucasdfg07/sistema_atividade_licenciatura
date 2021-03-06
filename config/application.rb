require_relative 'boot'
require 'dotenv'
Dotenv.load('keys.env')

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SistemaAtividdes
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.i18n.default_locale = :'pt-BR'
    config.assets.initialize_on_precompile = false
    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :utc
    # config.action_mailer.default_url_options = { host: 'atpa.centro.iff.edu.br' }
    # config.action_mailer.smtp_settings = {
    #   :address => "mail.iff.edu.br",
    #   :port => 587,
    #   :domain => "iff.edu.br",
    #   :authentication => :login,
    #   :user_name => "napp_dirlic.centro@iff.edu.br",
    #   :password => "napp_dirlic123.",
    #   :enable_starttls_auto => true,
    #   :openssl_verify_mode  => 'none'
    #   }
    # config.assets.enabled = true
    config.action_mailer.default_url_options = { host: 'napp-dirlic.centro.iff.edu.br' }
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 25,
      domain:               'gmail.com',
      user_name:            "#{ENV["EMAIL_KEY"]}",
      password:             "#{ENV["PASSWORD_KEY"]}",
      authentication:       :plain,
      enable_starttls_auto: true
    }
    config.assets.enabled = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
