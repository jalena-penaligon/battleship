class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fire = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship_type)
    @ship = ship_type
  end

  def fired_upon?
    @fire
  end

  def fire_upon
    @fire = true
    ship.hit if empty? == false
  end

  def render(player_input = false)
    if fired_upon? == false && player_input == false
      "."
    elsif player_input && empty? && fired_upon? == false
      "."
    elsif fired_upon? && empty?
      "M"
    elsif fired_upon? && empty? == false && ship.sunk? == false
      "H"
    elsif fired_upon? && empty? == false && ship.sunk?
      "X"
    elsif fired_upon? == false && empty? == false && player_input
      "S"
    end
  end
end
