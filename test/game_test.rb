require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/computer'
require './lib/player'
require 'pry'

class GameTest < Minitest::Test
  def test_game_exists
    computer = Board.new
    player = Board.new
    game = Game.new(computer, player)

    assert_instance_of Game, game
  end

  def test_computer_test_turn
    computer = Board.new
    player = Board.new
    game = Game.new(computer, player)
    guess = game.generate_random_coord
    actual = player.cells.keys.include?(guess)

    assert_equal true, actual
  end



  def test_computer_can_take_turns
    board = Board.new
    computer = Computer.new(board)
    player = Player.new(board)
    game = Game.new(computer, player)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    computer.comp_placement(cruiser)
    computer.comp_placement(submarine)
    player.player_placement(cruiser, ["B2", "B3", "B4"])
    player.player_placement(submarine, ["C3", "D3"])
    game.computer_take_turn("D3")

    actual = player.board.cells["D3"].fired_upon?
    assert_equal true, actual
  end

  def test_player_can_take_turns
    board = Board.new
    computer = Computer.new(board)
    player = Player.new(board)
    game = Game.new(computer, player)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    computer.comp_placement(cruiser)
    computer.comp_placement(submarine)
    player.player_placement(cruiser, ["B2", "B3", "B4"])
    player.player_placement(submarine, ["C3", "D3"])
    game.player_take_turn("D3")

    actual = computer.board.cells["D3"].fired_upon?
    assert_equal true, actual
  end

end
