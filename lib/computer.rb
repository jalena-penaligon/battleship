class Computer
  # attr_reader :computer_board
  def initialize(computer_board, player_board)
    @computer_board = computer_board
    @player_board = player_board
  end

  def select_coordinates(ship_type)
    coord_keys = @computer_board.cells.keys
    select = ship_type.length
    random_coords = []
    key_1 = coord_keys.sample
    random_coords.unshift(key_1)
    key_index = coord_keys.index(key_1.to_s)
      (select - 1).times do
      random_coords.unshift(coord_keys[key_index -= 1])
    end
    return random_coords
  end

  def validate_random_placement(ship_type)
    random_coords = select_coordinates(ship_type)
    until @computer_board.valid_placement?(ship_type, random_coords) == true
      random_coords = select_coordinates(ship_type)
    end
    return random_coords
  end

  def comp_placement(ship_type)
    random_coords = validate_random_placement(ship_type)
    random_coords.each do |cell|
      @computer_board.cells[cell].place_ship(ship_type)
    end
  end

  def random_guess
    keys = @player_board.cells.keys
    guess = keys.sample
    keys.delete(guess)
    return guess
  end

  def take_turn
    guess = random_guess
    @player_board.cells[guess].fire_upon
    return guess
  end



end
