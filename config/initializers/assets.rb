Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( delete_account.js quantity-plus-minus.js )
Rails.application.config.assets.precompile += %w( style.css )