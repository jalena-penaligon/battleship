class Player
# attr_reader :board
  def initialize(player_board, computer_board)
    @player_board = player_board
    @computer_board = computer_board
  end

  def validate_input_placement(ship_type, input_coords)
    @player_board.valid_placement?(ship_type, input_coords)
  end

  def player_placement(ship_type, input_coords)
    validate_input_placement(ship_type, input_coords)
    input_coords.each do |cell|
      @player_board.cells[cell].place_ship(ship_type)
    end
  end

  def take_turn(coordinate)
    @computer_board.cells[coordinate].fire_upon
  end
end
