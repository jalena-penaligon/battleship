class Board
  attr_reader :cells,
              :letter_coord,
              :number_coord,
              :ordinal

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
    @letter_coord = []
    @number_coord = []
    @ordinal = []
  end

  def valid_coordinate?(coordinate)
      @cells.key?(coordinate)
  end

  def ship_length_placement(ship, coordinates)
    ship.length == coordinates.count
  end



  def split_coordinates(ship, coordinates)
    coordinates.map! do |coordinate|
      coordinate.split(//)
    end

    letter_coord = []
    number_coord = []

    coordinates.each do |coordinate_pair|
      @letter_coord << coordinate_pair[0]
      @number_coord << coordinate_pair[1].to_i
    end
  end

  def convert_to_ordinals
    @ordinal = []
    # binding.pry

    letter_coord.each do |coordinate|
      @ordinal << coordinate.ord
    end
    return @ordinal
  end


  def coordinates_consecutive

    test_1 = letter_coord.uniq.count == 1 && number_coord.sort.each_cons(2).all? { |x,y| y == x + 1 } == true

    # horizontal_valid = letters_same && numbers_consecutive
    # vertical_valid = numbers_same && letters_consecutive
    # horizontal_valid || vertical_valid

    test_2 = number_coord.uniq.count == 1 && ordinal.sort.each_cons(2).all? { |x,y| y == x + 1 } == true

    if test_1 || test_2
      true
    else
      false
    end
  end

  def valid_placement?(ship, coordinates)
    split_coordinates(ship, coordinates)
    convert_to_ordinals
    coordinates_consecutive && ship_length_placement(ship, coordinates)

  end
end
