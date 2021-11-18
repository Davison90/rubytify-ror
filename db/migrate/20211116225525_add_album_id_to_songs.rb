class AddAlbumIdToSongs < ActiveRecord::Migration[6.0]
  def change
    add_reference :songs, :album, null: false, foreign_key: true
  end
end
