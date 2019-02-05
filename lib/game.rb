class Game
  attr_reader :computer,
              :player
  def initialize(computer, player)
    @computer = computer
    @player = player
  end

  def generate_random_coord
    options = player.cells.keys
    guess = options.shuffle.pop
    options.delete(guess)
    return guess
  end

  def computer_take_turn(coordinate)
    coordinate = generate_random_coord
    player.board.cells[coordinate].fire_upon
  end

  def player_take_turn(coordinate)
    computer.board.cells[coordinate].fire_upon
  end
end
