OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, CONFIG[:facebook][:key], CONFIG[:facebook][:secret], image_size: 'small'
end