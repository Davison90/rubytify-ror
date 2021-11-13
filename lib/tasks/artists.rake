namespace :artists do
  task :artist => :environment do

    count_artist = 0

    artist = ["Artic Monkeys",
              "Metallica      ",
              "Nirvana",
              "Diomedes Diaz",
              "AC/DC",
              "311",
              "Calle 13",
              "BTS",
              "El ultimo de la fila",
              "Atercipelados",
              "Alci Acosta",
              "Green Day",
              "Tormenta",
              "Chuck Berry",
              "Joe Cuba",
              "Compay Segundo",
              "Buena Vista Social Club",
              "Masacre",
              "Pantera",
              "Ruben Blades",
              "Los Hermanos Zuleta",
              "Carlos Vives",
              "Muse"
    ]

    RSpotify.authenticate("37a318ec153f4cfda51cc89bf51f9da1", "f9d072897164452f96cf592f1d73c5ee")

    Artist.delete_all
    Album.delete_all
    Song.delete_all

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
          
          albums = RSpotify::Base.search(art, 'album')
          albums.each_with_index { |alb, y|
            albums_image = albums[y].instance_variable_get(:@images)

            Album.create(spotify_id: albums[y].instance_variable_get(:@id),
              spotify_id_artist: artists[0].instance_variable_get(:@id),
              name: albums[y].instance_variable_get(:@name),
              image: albums_image[2]['url'],
              spotify_url: albums[y].instance_variable_get(:@href),
              total_tracks: albums[y].instance_variable_get(:@total_tracks)
            )
          }

          songs = RSpotify::Base.search(art, 'track')
          songs.each_with_index { |song, z|
            Song.create(name: songs[z].instance_variable_get(:@name),
              spotify_url: songs[z].instance_variable_get(:@href),
              preview_url: songs[z].instance_variable_get(:@preview_url),
              durations_ms: songs[z].instance_variable_get(:@duration_ms),
              explicit: songs[z].instance_variable_get(:@explicit).to_s,
              spotify_id: songs[z].instance_variable_get(:@id),
              spotify_id_album: songs[z].instance_variable_get(:@album).instance_variable_get(:@id)
            )
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
