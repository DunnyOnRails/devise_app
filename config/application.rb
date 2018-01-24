require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# ENV['RAILS_ADMIN_THEME'] = 'example_theme'
ENV['RAILS_ADMIN_THEME'] = 'rollincode'

module DeviseApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    ## -- Added by DD to make sure that rails is loading files from my LIB folder - added intially for a DEVISE-redirect- ##
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
