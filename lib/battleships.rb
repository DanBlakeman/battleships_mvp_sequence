require 'sinatra/base'
require_relative 'player'
require_relative 'destroyer'

class Battleships < Sinatra::Base

  enable :sessions

  get '/' do
    session[:player] = Player.new
    erb :index
  end

  post '/placed' do
    session[:player].place(Destroyer, (params[:to_place].upcase), :east)
    erb :placed
  end

  post '/fire' do
    if session[:player].receive_hit(params[:to_fire_at]) == :miss
      erb :missed
    else
      "#{session[:player].receive_hit(params[:to_fire_at])}! YOU'VE WON!"
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
