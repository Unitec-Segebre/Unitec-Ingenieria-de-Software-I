require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AgriculturaDePrecision
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = [:es]
    config.i18n.default_locale = :es
    config.i18n.fallbacks = true
    config.i18n.fallbacks = [:en]
  end
end
