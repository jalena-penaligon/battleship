require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test
  def test_game_exists
    comp_board = Board.new
    user_board = Board.new
    game = Game.new(comp_board, user_board)


    assert_instance_of Game, game
  end

  def test_computer_makes_a_comp_board
    comp_board = Board.new
    user_board = Board.new
    game = Game.new(comp_board, user_board)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    comp_board.place(cruiser, ["A1", "A2", "A3"])
    comp_board.place(submarine, ["C1", "C2"])
    actual = comp_board.render(true)
    expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC S S . . \nD . . . . \n"
    assert_equal actual, expected
  end

  def test_computer_makes_a_user_board
    skip
    comp_board = Board.new
    user_board = Board.new
    game = Game.new(comp_board, user_board)

    assert_equal
  end

  def test_computer_makes_a_computer_board_at_random
    comp_board = Board.new
    user_board = Board.new
    game = Game.new(comp_board, user_board)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    game.comp_placement(cruiser)
    game.comp_placement(submarine)
    actual = comp_board.render(true)
    binding.pry

    expected = comp_board.render.include?("S")
    assert_equal true, expected
  end

end
