# for heroku
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '217942814925150', 'a61046f5eb5f14c8571d51c404eef8e2'
  provider :twitter, 'uESiC9KsmBPPqdmlMEmQzQ', 'hhA4HLlk3q1Dqe2RdiaFOjAa3xFc32qhmdmQpEg'
  provider :github, '', ''
  provider :google_oauth2, '', ''
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end
