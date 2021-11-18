require 'json'
require 'awesome_print'
module Api
  module V2
    class ArtistsController < ApplicationController
      
      def index
        host = request.base_url
        RSpotify.authenticate("37a318ec153f4cfda51cc89bf51f9da1", "f9d072897164452f96cf592f1d73c5ee")
        @artists = Artist.all.select('id, name, image, genres,  popularity, spotify_url, spotify_id').order('popularity DESC')

        info_artist = ''
        @artists.each do |art|
          info_artist += "<strong>id:</strong> #{art.id} <br>"
          info_artist += "<strong>spotify_id:</strong> #{art.spotify_id} <br>"
          info_artist += "<strong>name:</strong> #{art.name} <br>"
          info_artist += "<strong>Image: </strong><img src=#{art.image} alt=#{art.name}><br>"
          
          unless art.genres.nil?
            info_artist += "<strong>genres:</strong> #{art.genres}<br>"
          end

          info_artist += "<strong>popularity:</strong> #{art.popularity}<br>"
          info_artist += "<strong>spotify_url:</strong> <a href=#{art.spotify_url}>#{art.spotify_url}</a> <br>"
          info_artist += "<a href=#{host}/api/v1/artists/#{art.id}/albums>Ver albumes</a><br>"
          info_artist += "-----------------------------------------------------------------<br>"
        end
        render html: "#{info_artist}".html_safe, content_type: 'text/html'
      end

      def show_albums
        host = request.base_url
        @albums = Album.where(artist_id: params[:artist_id])
        info_album = ""

        @albums.each do |alb|
          info_album += "<strong>id:</strong> #{alb.id} <br>"
          info_album += "<strong>spotify_id:</strong> #{alb.spotify_id} <br>"
          info_album += "<strong>name:</strong> #{alb.name}<br>"
          info_album += "<strong>Image:</strong> <img src='#{alb.image}' alt=#{alb.name}><br>"
          
          unless alb.spotify_url.nil?
            info_album += "<strong>spotify_url:</strong> <a href=#{alb.spotify_url}>#{alb.spotify_url}</a> <br>"
          else
            info_album += "<strong>spotify_url:</strong> SIN DATOS<br>"
          end

          unless alb.total_tracks.nil?
            info_album += "<strong>total_tracks:</strong> #{alb.total_tracks}<br>"
          else
            info_album += "<strong>total_tracks:</strong> SIN DATOS<br>"
          end

          info_album += "<strong>Songs of the album:</strong> <a href=#{host}/api/v1/albums/#{alb.id}/songs>#{alb.name}</a><br>"
          info_album += "--------------------------------------------------------------------<br>"
        end
        render html: "#{info_album}".html_safe, content_type: 'text/html'
      end
    end
  end

  module V1
    class ArtistsController < ApplicationController
      
      def index
        RSpotify.authenticate("37a318ec153f4cfda51cc89bf51f9da1", "f9d072897164452f96cf592f1d73c5ee")
        @artists = Artist.all.select('id, name, image, genres,  popularity, spotify_url').order('popularity DESC')
        info= {"data" => @artists}
        data = ap(JSON.parse(info.to_json))
        render json: JSON.pretty_generate(data.as_json)
      end

      def show_albums
        @albums = Album.select("id, name, image, spotify_url, total_tracks, spotify_id").where(artist_id: params[:artist_id])
        info= {"data" => @albums}
        data = ap(JSON.parse(info.to_json))
        render json: JSON.pretty_generate(data.as_json)
      end
    end
  end
end
