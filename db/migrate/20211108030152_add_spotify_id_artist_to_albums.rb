class AddSpotifyIdArtistToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :spotify_id_artist, :string
  end
end
