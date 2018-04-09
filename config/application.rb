require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.generators.system_tests = nil
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies # Required for all session management
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { host: ENV['MAIL_HOST'], port: ENV['MAIL_PORT'] }
    config.action_mailer.perform_deliveries = true
    config.action_mailer.smtp_settings = {
        address:              ENV['SMTP_ADDR'],
        port:                 ENV['SMTP_PORT'],
        domain:               ENV['SMTP_DOMAIN'],
        user_name:            ENV['SMTP_USER'],
        password:             ENV['SMTP_PASS'],
        authentication:       :plain,
        enable_starttls_auto: true
    }
  end
end
