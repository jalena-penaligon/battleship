class Player
attr_reader :board
  def initialize(board)
    @board = board
  end

  def validate_input_placement(ship_type, input_coords)
    @board.valid_placement?(ship_type, input_coords)
  end

  def player_placement(ship_type, input_coords)
    validate_input_placement(ship_type, input_coords)
    input_coords.each do |cell|
      @board.cells[cell].place_ship(ship_type)
    end
  end
end
