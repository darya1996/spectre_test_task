require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module SpectreTestTask
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.autoload_paths << Rails.root.join('lib')
    config.assets.initialize_on_precompile = false
    require File.expand_path('../settings', __FILE__)
  end
end
