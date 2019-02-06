class Game
  attr_reader :computer,
              :player,
              :computer_board,
              :player_board
  def initialize
    @computer_board = Board.new
    @player_board = Board.new
    @computer = Computer.new(@computer_board, @player_board)
    @player = Player.new(@player_board, @computer_board)
  end

  def start
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @computer.comp_placement(cruiser)
    @computer.comp_placement(submarine)
  end

  def player_setup(cruis_coords, sub_coords)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @player.player_placement(cruiser, cruis_coords)
    @player.player_placement(submarine, sub_coords)
  end

  def health(board)
    total_health = 0
      board.cells.each do |coordinate, cell|
        if cell.empty? == false
          total_health += cell.ship.health
        end
      end
    return total_health
  end

  def turn(coordinate)
    @player.take_turn(coordinate)
    @computer.take_turn
  end

  def feedback

  end


end
