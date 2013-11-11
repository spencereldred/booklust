Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  # provider :google_oauth2, '960109259042.apps.googleusercontent.com', '5uUrVYqLhxUoNvHN4PY_6UcS'
  provider :facebook, ENV['FACEBOOK_ID'], ENV['FACEBOOK_SECRET']
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end
