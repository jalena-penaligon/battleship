require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/computer'
require './lib/player'
require 'pry'

class ComputerTest < Minitest::Test
  def test_computer_exists
    board = Board.new
    computer = Computer.new(board)

    assert_instance_of Computer, computer
  end

  def test_computer_makes_a_comp_board
    board = Board.new
    computer = Computer.new(board)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["C1", "C2"])
    actual = board.render(true)
    expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC S S . . \nD . . . . \n"
    assert_equal actual, expected
  end

  def test_select_random_coordinates
    board = Board.new
    computer = Computer.new(board)
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, computer.select_coordinates(cruiser).count
  end

  def test_random_coordinates_must_have_valid_placement
    board = Board.new
    computer = Computer.new(board)
    cruiser = Ship.new("Cruiser", 3)
    random_coords = computer.validate_random_placement(cruiser)

    assert_equal true, board.valid_placement?(cruiser, random_coords)
  end

  def test_computer_makes_a_computer_board_at_random
    board = Board.new
    computer = Computer.new(board)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    computer.validate_random_placement(cruiser)
    computer.validate_random_placement(submarine)
    computer.comp_placement(cruiser)
    computer.comp_placement(submarine)
    actual = board.render(true).include?("S")
    assert_equal true, actual
  end
end
