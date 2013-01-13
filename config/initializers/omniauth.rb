OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, CONFIG[:facebook][:key], CONFIG[:facebook][:secret]
  provider :google_oauth2, CONFIG[:google][:key], CONFIG[:google][:secret],
          {
            scope: 'userinfo.email,userinfo.profile',
            access_type: 'online',
            approval_prompt: ''
          }
end