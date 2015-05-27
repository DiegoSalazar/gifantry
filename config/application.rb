require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gifantry
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de


    config.assets.precompile += %w(*.svg *.eot *.woff *.ttf *.png *.jpg *.jpeg *.gif)

    config.paperclip_defaults = {
      storage: :s3,
      path: "/entries/:id/:filename",
      s3_credentials: {
        bucket: ENV.fetch('GIFANTRY_S3_BUCKET_NAME', "gifantry"),
        access_key_id: ENV.fetch('GIFANTRY_AWS_ACCESS_KEY_ID', ENV["AWS_ACCESS_KEY_ID"]),
        secret_access_key: ENV.fetch('GIFANTRY_AWS_SECRET_ACCESS_KEY', ENV["AWS_SECRET_ACCESS_KEY"])
      }
    }

    config.active_record.raise_in_transactional_callbacks = true
  end
end
