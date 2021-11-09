class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :spotify_url
      t.string :preview_url
      t.string :durations_ms
      t.string :explicit
      t.string :spotify_id
      t.timestamps
    end
  end
end
