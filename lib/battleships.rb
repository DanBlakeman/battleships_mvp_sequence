require 'sinatra/base'
require_relative 'player'
require_relative 'destroyer'

class Battleships < Sinatra::Base
  enable :sessions

  @@turn = 0
  PLAYER_ONE = Player.new
  PLAYER_TWO = Player.new

  get '/' do
    if @@turn == 0
      session[:player] = 1
      @@turn += 1
      "Welcome player 1, Waiting for other player"
    elsif @@turn == 1 && session[:player] == 1
      "Welcome back player 1, Waiting for other player"
    elsif @@turn == 1
      session[:player] = 2
      @@turn += 1
      "You've joined a game, please wait for player 1 to place ships"
    elsif @@turn == 2 && session[:player] == 1
      @@turn += 1
      erb :index
    elsif @@turn == 3 && session[:player] == 2
      erb :index
    end
  end


  post '/placed' do
    if session[:player] == 1
      PLAYER_ONE.place(Ship, (params[:place_ship_1].upcase), :east)
      PLAYER_ONE.place(Ship, (params[:place_ship_2].upcase), :east)
      PLAYER_ONE.place(Ship, (params[:place_ship_3].upcase), :east)
        erb :placed
    elsif session[:player] == 2
      PLAYER_TWO.place(Ship, (params[:place_ship_1].upcase), :east)
      PLAYER_TWO.place(Ship, (params[:place_ship_2].upcase), :east)
      PLAYER_TWO.place(Ship, (params[:place_ship_3].upcase), :east)
        erb :placed
    end
  end

  post '/fire' do
    if PLAYER_ONE.lost?
      "Game Over PLAYER ONE Loses! <a href='/'>Play again?</a>"
    elsif PLAYER_TWO.lost?
      "Game Over PLAYER TWO Loses! <a href='/'>Play again?</a>"
    elsif session[:player] == 1 &&
      PLAYER_TWO.receive_hit(params[:to_fire_at].upcase) == :miss
      erb :missed
    elsif session[:player] == 2 &&
      PLAYER_ONE.receive_hit(params[:to_fire_at].upcase) == :miss
      erb :missed
    else
      erb :hit
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
