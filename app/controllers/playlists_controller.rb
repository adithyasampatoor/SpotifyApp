class PlaylistsController < ApplicationController
  def index
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    playlists = spotify_user.playlists
    save_artist_info playlists, spotify_user.email
    @artists = ExtractInfo.all
  end

  def search 
    @artists = []
    if params[:search] == nil
      @artists = ExtractInfo.all
    else  
      keywords = params[:search].split(',')
      @artists = ExtractInfo.search_all_artists keywords
    end 
    render :index
  end

  private

  def save_artist_info playlists, user_email
    return false if playlists == [] or playlists == nil
    artists_info = []
    playlists.each do |playlist|
      playlist.tracks.each do |track|
        track.artists.each do |artist|
          artists_info << {name: artist.name, genre: artist.genres}
        end
      end 
    end

    artists_info = artists_info.uniq!

    artists_info.each do |info|
      ExtractInfo.create(email: user_email, artist_name: info[:name], artist_genre: info[:genre].join(', '))
    end
  end 
end
