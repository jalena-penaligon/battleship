require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

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
end
