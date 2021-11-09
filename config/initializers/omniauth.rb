require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "37a318ec153f4cfda51cc89bf51f9da1", "f9d072897164452f96cf592f1d73c5ee", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
