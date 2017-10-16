require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Classy
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]
    config.eager_load_paths += Dir[Rails.root.join("app", "forms", "concerns")]
    # config.i18n.default_locale = :vi
    config.time_zone = "Hanoi"
  end
end
