Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :artists
      get "artists/albums", to: "artists#show_albums"
      get "artists/:spotify_id_artist/albums", to: "artists#show_albums"
      
    end
  end

  namespace :api do
    namespace :v1 do
      resources :albums
      get "albums/:spotify_id_album/songs", to: "albums#index"
      
    end
  end

  namespace :api do
    namespace :v1 do
      resources :songs
      get "genres/:genre/random_song", to: "songs#index"

    end
  end
  get '/auth/spotify/callback', to: 'users#spotify'
  root to: "home#index"

end
