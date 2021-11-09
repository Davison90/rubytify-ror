class AddSpotifyIdAlbumToSongs < ActiveRecord::Migration[6.0]
  def change
    add_column :songs, :spotify_id_album, :string
  end
end
