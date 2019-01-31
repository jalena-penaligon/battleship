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

  def test_split_and_store_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expected = [["A", "2"], ["A", "3"], ["A", "4"]]
    assert_equal expected, board.split_coordinates(cruiser, ["A2", "A3", "A4"])

    expected = ["A", "A", "A"]
    assert_equal expected, board.letter_coord

    expected = [2, 3, 4]
    assert_equal expected, board.number_coord
  end

  def test_it_can_convert_letters_to_ordinals
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.split_coordinates(cruiser, ["B1", "B4", "A1"])

    expected = [66, 66, 65]
    assert_equal expected, board.convert_to_ordinals
  end

  def test_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.split_coordinates(cruiser, ["A2", "A3", "A4"])

  end

  def test_valid_placement
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
