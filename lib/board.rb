class Board

  POSITIONS = ['A1', 'A2', 'A3', 'A4', 'B1', 'B2', 'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 'D1', 'D2', 'D3', 'D4']

  CELLS = Hash.new
  POSITIONS.map { |position| CELLS[position] = Cell.new(position) }

  def valid_coordinate?(coordinate)
    CELLS.key?(coordinate)
  end

  def ship_length_placement(ship, coordinates)
    ship.length == coordinates.count
  end

  def split_coordinates(ship = nil, coordinates)
    coordinates.map { |coordinate| coordinate.split(//) }
  end

  def store_letter_coords(split_coords)
    split_coords.map { |coordinate_pair| coordinate_pair[0] }
  end

  def store_number_coords(split_coords)
    split_coords.map { |coordinate_pair| coordinate_pair[1].to_i }
  end

  def convert_to_ordinals(letter_coords)
    letter_coords.map { |coordinate| coordinate.ord }
  end

  def unique?(split_coords)
    split_coords.uniq.count == 1
  end

  def consecutive?(split_coords)
    split_coords.each_cons(2).all? { |x,y| y == x + 1 }
  end

  def unique_or_consecutive(validation_1, validation_2)
    validation_1 || validation_2
  end

  def overlap?(ship, coordinates)
    coordinates.all? { |cell| CELLS[cell].empty? }
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
    coordinates.each { |cell| CELLS[cell].place_ship(ship) }
  end

  def split_horiz_coordinates
    board_number_coords = CELLS.keys
    split_coords = split_coordinates(board_number_coords)
    board_number_coords = store_number_coords(split_coords).uniq
  end

  def split_vert_coordinates
    board_letter_coords = CELLS.keys
    split_coords = split_coordinates(board_letter_coords)
    board_letter_coords = store_letter_coords(split_coords).uniq
  end

  def render_horizontal
    horiz_coord = split_horiz_coordinates
    string_part_1 = "  "
    string_part_2 = []
    string_part_3 = "\n"
    horiz_coord.each { |num| string_part_2 << "#{num} " }
    (string_part_1 + string_part_2.join.to_s + string_part_3)
  end

  def render(player_input = false)
    vert_coord = split_vert_coordinates
    board_render = render_horizontal
    vert_coord.map do |letter|
      board_render << letter + " "
      CELLS.select do |coordinates, cell_object|
        if coordinates.include?(letter)
          board_render << CELLS[coordinates].render(player_input) + " "
        end
      end
      board_render << "\n"
    end
    board_render
  end

end
