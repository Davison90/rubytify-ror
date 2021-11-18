class AddArtistIdToAlbums < ActiveRecord::Migration[6.0]
  def change
    add_reference :albums, :artist, null: true, foreign_key: true
  end
end
