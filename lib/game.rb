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

  def player_feedback(coordinate)
    if @computer_board.cells[coordinate].render == "M"
      return "Your shot on #{coordinate} was a miss!"
    elsif @computer_board.cells[coordinate].render == "H"
      return "Your shot on #{coordinate} was a hit!"
    elsif @computer_board.cells[coordinate].render == "S"
      return "Your shot on #{coordinate} sunk my battleship!!"
    end
  end

  def computer_feedback(guess)
    if @player_board.cells[guess].render == "M"
      return "Your shot on #{guess} was a miss!"
    elsif @player_board.cells[guess].render == "H"
      return "Your shot on #{guess} was a hit!"
    elsif @player_board.cells[guess].render == "S"
      return "Your shot on #{guess} sunk my battleship!!"
    end
  end

  def turn(coordinate)
    @player.take_turn(coordinate)
    guess = @computer.take_turn
    computer_feedback(guess)
    player_feedback(coordinate)
  end




end
