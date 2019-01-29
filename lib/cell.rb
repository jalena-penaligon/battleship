class Cell
  attr_reader :coordinate
  attr_accessor :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

  def ship
    @ship
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_type)
    @ship = ship_type
  end
end
