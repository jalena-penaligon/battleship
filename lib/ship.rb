class Ship
  attr_reader :name, :length
  def initialize(name, length)
    @name = name
    @length = length
    @health_count = length
  end

  def health
    @health_count
  end

  def sunk?
    @health_count == 0
  end

  def hit
    @health_count -= 1
  end
end
