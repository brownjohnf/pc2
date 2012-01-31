# for heroku
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '217942814925150', 'a61046f5eb5f14c8571d51c404eef8e2'
  provider :twitter, 'XhPJ732UpRSSawGZVAh3oQ', 'S4FIZTRCpDWsJNFzmEgdfIa5upRBo74yA28tZbxTo'
  provider :github, '', ''
  provider :google_oauth2, '', ''
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end
