class Board
  attr_reader :cells,
              :letter_coord,
              :number_coord,
              :ordinal,
              :test_1,
              :test_2

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
    #splits coordinates into 2 separate objects
    coordinates.map! do |coordinate|
      coordinate.split(//)
    end
  end

  def stores_split_coordinates(ship, coordinates)
    #creates empty arrays to store letter and number coordinates
    letter_coord = []
    number_coord = []
    #shovels letter and number coordinates into empty arrays & converts number strings to integers
    coordinates.each do |coordinate_pair|
      @letter_coord << coordinate_pair[0]
      @number_coord << coordinate_pair[1].to_i
    end
  end

  def convert_store_letters_to_ordinals(ship, coordinates)
    #creates empty array to store ordinal value of letters
    @ordinal = []
    #convert letters to ordinals and shovels into empty array
    letter_coord.each do |coordinate|
      ordinal << coordinate.ord
      end
  end

  def are_coordinates_unique_and_consecutive(ship, coordinates)

    test_1 = letter_coord.uniq.count == 1 && number_coord.sort.each_cons(2).all? { |x,y| y == x + 1 } == true

    test_2 = number_coord.uniq.count == 1 && ordinal.sort.each_cons(2).all? { |x,y| y == x + 1 } == true
  end


  def placement_return_values(ship, coordinates)
    if test_1 || test_2
      true
    else
      false
    end
  end

  def valid_placement?(ship, coordinates)
    split_coordinates(ship, coordinates)
    stores_split_coordinates(ship, coordinates)
    convert_store_letters_to_ordinals(ship, coordinates)
    are_coordinates_unique_and_consecutive(ship, coordinates)
    ship_length_placement(ship, coordinates) &&
    placement_return_values(ship, coordinates)

  end
end
