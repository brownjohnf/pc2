Rails.application.config.middleware.use OmniAuth::Builder do
  # Create apps with the following providers, and then insert the keys and secrets below.
  provider :facebook, '', ''
  provider :twitter, '', ''
  provider :github, '', ''
  provider :google_oauth2, '', ''
end
