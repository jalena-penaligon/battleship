require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/player'
require './lib/game'
require 'pry'

class ComputerTest < Minitest::Test
  def test_computer_exists
    computer_board = Board.new
    player_board = Board.new
    computer = Computer.new(computer_board, player_board)

    assert_instance_of Computer, computer
  end

  def test_computer_makes_a_comp_board

    computer_board = Board.new
    player_board = Board.new
    computer = Computer.new(computer_board, player_board)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    computer_board.place(cruiser, ["A1", "A2", "A3"])
    computer_board.place(submarine, ["C1", "C2"])
    actual = computer_board.render(true)
    expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC S S . . \nD . . . . \n"
    assert_equal actual, expected
  end

  def test_select_random_coordinates
    computer_board = Board.new
    player_board = Board.new
    computer = Computer.new(computer_board, player_board)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, computer.select_coordinates(cruiser).count
  end

  def test_random_coordinates_must_have_valid_placement
    computer_board = Board.new
    player_board = Board.new
    computer = Computer.new(computer_board, player_board)
    cruiser = Ship.new("Cruiser", 3)
    random_coords = computer.validate_random_placement(cruiser)

    assert_equal true, computer_board.valid_placement?(cruiser, random_coords)
  end

  def test_computer_makes_a_computer_board_at_random
    computer_board = Board.new
    player_board = Board.new
    computer = Computer.new(computer_board, player_board)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    computer.validate_random_placement(cruiser)
    computer.validate_random_placement(submarine)
    computer.comp_placement(cruiser)
    computer.comp_placement(submarine)
    actual = computer_board.render(true).include?("S")
    assert_equal true, actual
  end

  def test_computer_takes_random_turn
    player_board = Board.new
    computer_board = Board.new
    computer = Computer.new(computer_board, player_board)
    computer.take_turn

    assert_equal true, player_board.render.include?("M")
  end
end
