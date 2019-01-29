class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fire = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_type)
    @ship = ship_type
  end

  def fired_upon?
    @fire
  end

  def fire_upon
    @fire = true
    if empty? == false
      ship.hit
    end
  end

end
