class Ship
  attr_reader :position, :hits, :size, :start_position

  def initialize start_position, direction, size = 1
    @direction = direction
    @start_position = start_position
    @size = size
    calculate_full_position
    @hits = []
  end

  def hit position
    return :miss unless self.position.include? position
    hits << position unless hits.include? position
    :hit
  end

  def collided? other_ship
    (position - other_ship.position).size < size
  end

  def sunk?
    @hits.size >= @size
  end

  private

  attr_reader :direction, :start_position

  def calculate_full_position
    @position = [start_position]
    (@size - 1).times do
      @position << send(@direction, @position.last)
    end
  end

  def west position
    (position[0].ord - 1).chr + position[1]
  end

  def east position
    (position[0].ord + 1).chr + position[1]
  end

  def south position
    position[0] + (position[1].to_i + 1).to_s
  end

  def north position
    position[0] + (position[1].to_i - 1).to_s
  end
end
