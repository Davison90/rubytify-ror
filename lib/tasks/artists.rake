namespace :artists do
  task :clean => :environment do
    Song.delete_all
    Album.delete_all
    Artist.delete_all
  end

  task :artist => :environment do
    count_artist = 0
    artist = CONFIG["list"]

    RSpotify.authenticate("37a318ec153f4cfda51cc89bf51f9da1", "f9d072897164452f96cf592f1d73c5ee")

    Song.delete_all
    Album.delete_all
    Artist.delete_all

    artist.each_with_index { |art, x|
      begin
        unless art.nil?
          artists = RSpotify::Base.search(art, 'artist')
          artists_image = artists[0].instance_variable_get(:@images)

          unless artists_image.nil?
            image = artists_image[artists_image.length - 1]['url']
          else
            image = ""
          end

          Artist.create(name: art,
            image: image,
            genres: artists[0].instance_variable_get(:@genres),
            popularity: artists[0].instance_variable_get(:@popularity),
            spotify_url: artists[0].instance_variable_get(:@href),
            spotify_id: artists[0].instance_variable_get(:@id)
          )
          
          arti = Artist.find_by_name(art)
          albums = RSpotify::Base.search(art, 'album')
          albums.each_with_index { |alb, y|
            albums_image = albums[y].instance_variable_get(:@images)
            Album.create(spotify_id: albums[y].instance_variable_get(:@id),
              spotify_id_artist: artists[0].instance_variable_get(:@id),
              name: albums[y].instance_variable_get(:@name),
              image: albums_image[2]['url'],
              spotify_url: albums[y].instance_variable_get(:@href),
              total_tracks: albums[y].instance_variable_get(:@total_tracks),
              artist_id: arti.id
            )
          }

          songs = RSpotify::Base.search(art, 'track')      
          songs.each_with_index { |song, z|
            spotify_id_album = songs[z].instance_variable_get(:@album).instance_variable_get(:@id)
            album_id = Album.select('id').where(spotify_id: spotify_id_album)
            
            unless album_id.empty?
              Song.create(name: songs[z].instance_variable_get(:@name),
                spotify_url: songs[z].instance_variable_get(:@href),
                preview_url: songs[z].instance_variable_get(:@preview_url).to_s,
                durations_ms: songs[z].instance_variable_get(:@duration_ms).to_s,
                explicit: songs[z].instance_variable_get(:@explicit).to_s,
                spotify_id: songs[z].instance_variable_get(:@id),
                spotify_id_album: songs[z].instance_variable_get(:@album).instance_variable_get(:@id),
                album_id:  album_id[0]['id'].inspect
              )
            end
          }
          
          count_artist = count_artist + 1
          puts "\n Creado artista: #{art}"
          puts "----------------------------------------------------"
        end

      rescue ActiveRecord::RecordNotFound
        puts "Error en: ActiveRecord::RecordNotFound"

      rescue ActiveRecord::ActiveRecordError
        puts "Error en: ActiveRecord::ActiveRecordError"

      rescue
        puts "Error al crear artista: #{art}, está presentando fallos"

      rescue Exception
        puts "Error en: Exception"
        raise
      end
    }
    puts "Total artist created: #{count_artist} of #{artist.length}"
  end
end
