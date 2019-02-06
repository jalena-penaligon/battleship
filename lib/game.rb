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

  def player_setup_cruiser(cruis_coords)
    cruiser = Ship.new("Cruiser", 3)
    if @player_board.valid_placement?(cruiser, cruis_coords) == true
      @player.player_placement(cruiser, cruis_coords)
    else
      return false
    end
  end

  def player_setup_submarine(sub_coords)
    submarine = Ship.new("Submarine", 2)
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
    elsif @computer_board.cells[coordinate].render == "X"
      return "Your shot on #{coordinate} sunk my battleship!!"
    end
  end

  def computer_feedback(guess)
    if @player_board.cells[guess].render == "M"
      return "My shot on #{guess} was a miss!"
    elsif @player_board.cells[guess].render == "H"
      return "My shot on #{guess} was a hit!"
    elsif @player_board.cells[guess].render == "X"
      return "My shot on #{guess} sunk my battleship!!"
    end
  end

  def turn(coordinate)
    @player.take_turn(coordinate)
    guess = @computer.take_turn
    puts "#{computer_feedback(guess)}"
    puts "#{player_feedback(coordinate)}"
    return guess
  end

  def end_game
    if health(@computer_board) == 0
      puts "You won!"
    elsif health(@player_board) == 0
      puts "I won!"
    end
  end
end
