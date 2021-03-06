# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( devise_custom.css )
Rails.application.config.assets.precompile += %w( respond.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( bootstrap-toggle.min.js )
Rails.application.config.assets.precompile += %w( custom.js )
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( jquery-ui.custom.min.js )
Rails.application.config.assets.precompile += %w( logo.png )
Rails.application.config.assets.precompile += %w( logo-min.png )
Rails.application.config.assets.precompile += %w( menu-active.png )
Rails.application.config.assets.precompile += %w( pattern.png )
Rails.application.config.assets.precompile += %w( breadcrumb.png )
