class HomeController < ApplicationController
  def index
    puts request.base_url
    host = request.base_url
    info_song = ""
    info_song += "<strong>Ver lista de artistas:</strong> <a href=#{host}/api/v1/artists>Artistas</a><br>"
    info_song += "<strong>Buscar canciones aleatorias por genero:</strong> <a href=#{host}/api/v1/genres/salsa/random_song>Default: Salsa</a><br>"
    render html: "#{info_song}".html_safe, content_type: 'text/html'
  end
end
