class HomeController < ApplicationController
  def index
    info_song = ""
    info_song += "<strong>Ver lista de artistas:</strong> <a href=http://localhost:3000/api/v1/artists>Artistas</a><br>"
    info_song += "<strong>Buscar canciones aleatorias por genero:</strong> <a href=http://localhost:3000/api/v1/genres/salsa/random_song>Default: Salsa</a><br>"
    render html: "#{info_song}".html_safe, content_type: 'text/html'
  end
end
