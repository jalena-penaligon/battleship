class Cell
  attr_reader :coordinate
  def initialize(coordinate)
    @coordinate = coordinate
  end

  def ship
  end

  def empty?
    ship == nil 
  end
end
