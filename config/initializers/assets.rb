# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Added in order to reference assets/img folder within the script in open_pages/sign_up.
Rails.application.config.assets.paths << Rails.root.join('assets', 'img')
# Added in order to reference assets/css folder .
Rails.application.config.assets.paths << Rails.root.join('assets', 'css')
# Added in order to reference assets/js folder .
Rails.application.config.assets.paths << Rails.root.join('assets', 'js')
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
