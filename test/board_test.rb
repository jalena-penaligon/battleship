require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class BoardTest < Minitest::Test
  def test_board_exists
    board = Board.new

  assert_instance_of Board, board
  end

  def test_cells_is_a_hash
    board = Board.new

    assert_equal Hash, board.cells.class
  end

  def test_keys_point_to_cell_object
    board = Board.new

    assert_equal Cell, board.cells["A1"].class
  end

  def test_there_are_16_keys
    board = Board.new

    assert_equal 16, board.cells.keys.count
  end

  def test_there_are_16_pairs
    board = Board.new

    assert_equal 16, board.cells.values.count
  end

  def test_that_coordinates_are_true
    board = Board.new
    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
  end

  def test_that_coordinates_are_false
    board = Board.new
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_placement_matches_length_of_ship
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    #we switched these to true because theoretically coordinates should be able to work in any order
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  end
end
