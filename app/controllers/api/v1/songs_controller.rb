require 'json'

module Api
  module V2
    class SongsController < ApplicationController

      def index
        @songs = RSpotify::Base.search(params[:genre], 'track')
        loop do
          @random_song = @songs.shuffle.first
          break if !@random_song.preview_url.nil?
        end

        info_song = ""
        info_song += "<strong>name:</strong> #{@random_song.name} <br>"
        info_song += "<strong>external_urls:</strong> <a href=#{@random_song.external_urls['spotify']}>#{@random_song.external_urls['spotify']}</a><br>"
        info_song += "<strong>preview_url:</strong> <a href=#{@random_song.preview_url}>#{@random_song.preview_url}</a><br>"
        info_song += "<strong>duration_ms:</strong> #{@random_song.duration_ms}<br>"
        info_song += "<strong>explicit:</strong> #{@random_song.explicit}<br>"
        render html: "#{info_song}".html_safe, content_type: 'text/html'

      end
    end
  end

  module V1
    class SongsController < ApplicationController

      def index
        @songs = RSpotify::Base.search(params[:genre], 'track')
        loop do
          @random_song = @songs.shuffle.first
          break if !@random_song.preview_url.nil?
        end

        array = [ "name" => @random_song.name,
                  "external_urls" => @random_song.external_urls['spotify'],
                  "preview_url" => @random_song.preview_url,
                  "duration_ms" => @random_song.duration_ms,
                  "explicit" => @random_song.explicit
        ]

        info= {"data" => array}
        data = ap(JSON.parse(info.to_json))
        render json: JSON.pretty_generate(data.as_json)

      end
    end
  end
end
