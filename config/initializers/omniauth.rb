# for localhost
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '175664355863485', 'ebe6eca80532b2d82982ea64bec77304'
  provider :twitter, 'w8kcCaZwobBBALc4inNo1g', 'nfCD1kIDXQ3eA72ys9aHZtnICMZgdOXtQ74HEgBg'
  provider :github, 'f5a3ee2fc018a0ed86f7', '3d085867f53f309a78902c90482be43f587aa0de'
  provider :google_oauth2, '85716079325.apps.googleusercontent.com', 'Wg9C0QLKD1FqNBJ-kT0NWrpW'
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end
