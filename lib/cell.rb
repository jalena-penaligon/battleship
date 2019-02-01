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
    if player_input == false
       if fired_upon? == false
         return "."
       elsif fired_upon? == true && empty? == true
         return "M"
       elsif fired_upon? == true && empty? == false
         return "H"
       elsif fired_upon? == true && empty? == false && ship.health_count = 0
         return "X"
       end
    else

      if fired_upon? == false
        return "."
      elsif fired_upon? == true && empty? == true
        return "M"
      elsif fired_upon? == true && empty? == false
        return "H"
      elsif fired_upon? == true && empty? == false && ship.health_count = 0
        return "X"
      elsif fired_upon? == false && empty? == false
        return "S"
      end
    end
  end
end
