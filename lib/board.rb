class Board
  attr_reader :cells
  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
  end

  def valid_coordinate?(coordinate)
      @cells.key?(coordinate)
  end

  def ship_length_placement(ship, coordinates)
    ship.length == coordinates.count
  end

  def coords_are_consecutive(ship, coordinates)
    binding.pry
    #splits coordinates into 2 separate objects
    coordinates.map! do |coordinate|
      coordinate.split(//)
    end

    #creates empty arrays to store first and second coordinates
    first_coord = []
    second_coord = []

    #creates empty array to store ordinal value of letters
    ordinal = []

    #shovels first and second coordinates into empty arrays & converts number strings to integers
    coordinates.each do |coordinate_pair|
      first_coord << coordinate_pair[0]
      second_coord << coordinate_pair[1].to_i
    end

    #convert letters to ordinals and shovels into empty array
    first_coord.each do |coordinate|
      ordinal << coordinate.ord
    end

    if
      if first_coord.uniq.count == 1 && second_coord.sort.each_cons(2).all? { |x,y| y == x + 1 } == true
        return true
      end
    elsif
      if second_coord.uniq.count == 1 && ordinal.sort.each_cons(2).all? { |x,y| y == x + 1 } == true
        return true
      end
    else
      return false
    end
  end

  def valid_placement?(ship, coordinates)
    # ship_length_placement(ship, coordinates) &&
    coords_are_consecutive(ship, coordinates)
  end
end
