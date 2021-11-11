require 'json'

module Api
  module V1
    class AlbumsController < ApplicationController

      def index
        RSpotify.authenticate("37a318ec153f4cfda51cc89bf51f9da1", "f9d072897164452f96cf592f1d73c5ee")
        @songs = Song.where(spotify_id_album: params[:spotify_id_album])
        info_song = ''

        @songs.each do |song|
          info_song += "<strong>name:</strong> #{song.name} <br>"
          unless song.spotify_url.nil?
            info_song += "<strong>spotify_url:</strong> <a href=#{song.spotify_url}>#{song.spotify_url}</a> <br>"
          else
            info_song += "<strong>spotify_url:</strong> NO DATA<br>"
          end

          info_song += "<strong>preview_url:</strong> <a href=#{song.preview_url}>#{song.preview_url}</a><br>"

          unless song.durations_ms.nil?
            info_song += "<strong>durations_ms:</strong> #{song.durations_ms}<br>"
          else
            info_song += "<strong>durations_ms:</strong> NO DATA<br>"
          end

          unless song.explicit.nil?
            info_song += "<strong>explicit:</strong> #{song.explicit}<br>"
          else
            info_song += "durations_ms: NO DATA<br>"
          end

          info_song += "<strong>spotify_id:</strong> #{song.spotify_id}<br>"
          info_song += "-----------------------------------------------------------------<br>"
        end
        render html: "#{info_song}".html_safe, content_type: 'text/html'
      end
    end
  end

  module V2
    class AlbumsController < ApplicationController

      def index
        RSpotify.authenticate("37a318ec153f4cfda51cc89bf51f9da1", "f9d072897164452f96cf592f1d73c5ee")
        @songs = Song.where(spotify_id_album: params[:spotify_id_album])
        info= {"data" => @songs}
        data = ap(JSON.parse(info.to_json))
        render json: JSON.pretty_generate(data.as_json)
      end
    end
  end
end
