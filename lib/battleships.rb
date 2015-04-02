require 'sinatra/base'
require_relative 'player'
require_relative 'destroyer'

class Battleships < Sinatra::Base
  enable :sessions

  get '/' do
    session[:player] = Player.new
    session[:computer] = Player.new
    erb :index
  end

  def random_col
   (("A".."J").to_a.sample)
  end

  def random_row
    (("1".."10").to_a.sample)
  end

  post '/placed' do
    session[:player].place(Ship, (params[:place_ship_1].upcase), :east)
    session[:player].place(Ship, (params[:place_ship_2].upcase), :east)
    session[:player].place(Ship, (params[:place_ship_3].upcase), :east)
    session[:computer].place(Ship, (random_col + random_row).upcase, :east)
    session[:computer].place(Ship, (random_col + random_row).upcase, :east)
    session[:computer].place(Ship, (random_col + random_row).upcase, :east)
    erb :placed
  end

  post '/fire' do
    @computers_hit = session[:player].receive_hit(random_col + random_row)
    if session[:computer].lost?
      "hit! Game Over Computer Loses! <a href='/'>Play again?</a>"
    elsif session[:player].lost?
      "computer hit you! Game Over You Lose! <a href='/'>Play again?</a>"
    elsif session[:computer].receive_hit(params[:to_fire_at].upcase) == :miss
      erb :missed
    else
      erb :hit
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
