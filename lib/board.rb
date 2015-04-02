class Board
  attr_reader :ships

  def initialize
    @ships = []
    @hits = []
    @misses = []
  end

  def receive_hit position
    @ships.map { |ship| ship.hit(position) }.include?(:hit) ? :hit : :miss
  end

  def place ship
    fail 'collides with existing ship' if collision? ship
    fail 'cannot place ship outside board' if illegal_position? ship
    @ships << ship
  end

  def all_sunk?
    return false if @ships.empty?
    !@ships.map(&:sunk?).include? false
  end

  private

  def collision? ship
    @ships.each do |s|
      return true if s.collided? ship
    end
    false
  end

  def illegal_position? ship
    position = ship.position
    position = position.join if position.respond_to? :join
    !(position =~ /^([A-J][0-9])+$/)
  end
end
