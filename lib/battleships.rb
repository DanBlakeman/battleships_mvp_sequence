require 'sinatra/base'
require_relative 'player'
require_relative 'destroyer'

class Battleships < Sinatra::Base
  enable :sessions

  @@visitor_number = 0
  PLAYER_ONE = Player.new
  PLAYER_TWO = Player.new

  get '/' do
    if @@visitor_number == 0
      session[:player] = 1
      @@visitor_number += 1
      @player_num = 1
      "Welcome, Player 1! Please wait for another player to join!"
    elsif session[:player] == 1 && @@visitor_number = 1
      "Please wait for another player to join!"
    elsif @@visitor_number == 1
      session[:player] = 2
      @@visitor_number += 1
      @player_num = 2
      "Thanks for joining, waiting for Player 1 to place their ships!"
    elsif session[:player] == 1
      erb :index
    else
      "Snap Bang! This Game Is Full!"
    end
  end

  post '/placed' do
    session[:player].place(Ship, (params[:place_ship_1].upcase), :east)
    session[:player].place(Ship, (params[:place_ship_2].upcase), :east)
    session[:player].place(Ship, (params[:place_ship_3].upcase), :east)
    erb :placed
  end

  post '/fire' do
    if session[:player].receive_hit(params[:to_fire_at].upcase) == :miss
      erb :missed
    elsif session[:player].lost?
      "hit! Game Over, <a href='/'>Play again?</a>"
    else
      erb :hit
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
