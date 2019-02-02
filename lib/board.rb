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

  def split_coordinates(ship, coordinates)
    coordinates.map do |coordinate|
      coordinate.split(//)
    end
  end

  def store_letter_coords(split_coords)
    letter_coords = []
    split_coords.each do |coordinate_pair|
      letter_coords << coordinate_pair[0]
    end
    return letter_coords
  end

  def store_number_coords(split_coords)
    number_coord = []
    split_coords.each do |coordinate_pair|
      number_coord << coordinate_pair[1].to_i
    end
    return number_coord
  end

  def convert_to_ordinals(letter_coords)
    ordinal = []
    letter_coords.each do |coordinate|
      ordinal << coordinate.ord
    end
    return ordinal
  end

  def unique?(split_coords)
    split_coords.uniq.count == 1
  end

  def consecutive?(split_coords)
    # binding.pry
    split_coords.each_cons(2).all? do |x,y|
      y == x + 1
    end == true
  end

  def unique_or_consecutive(validation_1, validation_2)
    if validation_1 || validation_2
      true
    else
      false
    end
  end

  def overlap?(ship, coordinates)
    coordinates.all? do |cell|
      @cells[cell].empty?
    end
  end

  def valid_placement?(ship, coordinates)
    split_coords = split_coordinates(ship, coordinates)
    letter_coords = store_letter_coords(split_coords)
    number_coords = store_number_coords(split_coords)
    ordinal = convert_to_ordinals(letter_coords)
    unique_num = unique?(number_coords)
    unique_ord = unique?(ordinal)
    consecutive_num = consecutive?(number_coords)
    consecutive_ord = consecutive?(ordinal)
    validation_1 = unique_num && consecutive_ord
    validation_2 = consecutive_num && unique_ord
    unique_or_consecutive(validation_1, validation_2) && ship_length_placement(ship, coordinates) && overlap?(ship, coordinates)
  end

  def place(ship, coordinates)
    # binding.pry
    coordinates.each do |cell|
      @cells[cell].place_ship(ship)
    end
  end

end
