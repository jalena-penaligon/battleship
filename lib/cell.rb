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

  def render(player_input = false)
    #user input = false & fired_upon? is false (does not matter if it has a ship or not)
    #user input = true & empty? is true

    if fired_upon? == false && player_input == false
      return "."
    elsif player_input == true && empty? == true && fired_upon? == false
      return "."
    elsif fired_upon? == true && empty? == true
      return "M"
    elsif fired_upon? == true && empty? == false && ship.sunk? == false
      return "H"
    elsif fired_upon? == true && empty? == false && ship.sunk? == true
      return "X"
    elsif fired_upon? == false && empty? == false && player_input == true
      return "S"
    end

  end
end
