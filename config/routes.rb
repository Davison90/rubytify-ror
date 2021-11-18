Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1  do
      resources :artists
      get "artists/albums", to: "artists#show_albums"
      get "artists/:artist_id/albums", to: "artists#show_albums"
      
      resources :albums
      get "albums/:album_id/songs", to: "albums#index"

      resources :songs
      get "genres/:genre/random_song", to: "songs#index"
    end

    namespace :v2  do
      resources :artists
      get "artists/albums", to: "artists#show_albums"
      get "artists/:artist_id/albums", to: "artists#show_albums"
      
      resources :albums
      get "albums/:album_id/songs", to: "albums#index"

      resources :songs
      get "genres/:genre/random_song", to: "songs#index"
    end
  end


  get '/auth/spotify/callback', to: 'users#spotify'
  root to: "home#index"

end
