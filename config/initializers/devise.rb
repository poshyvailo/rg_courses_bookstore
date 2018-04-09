# frozen_string_literal: true

# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.secret_key = '3b68d0d1f14f9cfbf42b3640ab997d5bb99b7fa80cfed7da9ed54f6c872ce592bd63b91de858b2376b3d24f135ad54717d9e18bdcaab5ea1542792da1240b7a6'
  config.mailer_sender = 'bookstore@office.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.omniauth :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET']
end
