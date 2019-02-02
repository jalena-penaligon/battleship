
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

  def test_it_can_split_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    expected = [["A", "2"], ["A", "3"], ["A", "4"]]
    assert_equal expected, board.split_coordinates(cruiser, ["A2", "A3", "A4"])
  end

  def test_it_can_store_letter_coords
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    split_coords = board.split_coordinates(cruiser, ["A2", "A3", "A4"])
    expected = ["A", "A", "A"]
    assert_equal expected, board.store_letter_coords(split_coords)
  end

  def test_it_can_store_number_coords
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    split_coords = board.split_coordinates(cruiser, ["A2", "A3", "A4"])
    expected = [2, 3, 4]
    assert_equal expected, board.store_number_coords(split_coords)
  end

  def test_it_can_convert_letters_to_ordinals
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    split_coords = board.split_coordinates(cruiser, ["B1", "B4", "A1"])
    letter_coords = board.store_letter_coords(split_coords)

    expected = [66, 66, 65]
    assert_equal expected, board.convert_to_ordinals(letter_coords)
  end

  def test_are_coordinates_unique?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    split_coords = board.split_coordinates(cruiser, ["A2", "A3", "A4"])
    number_coords = board.store_number_coords(split_coords)
    letter_coords = board.store_letter_coords(split_coords)
    ordinal = board.convert_to_ordinals(letter_coords)
    refute board.unique?(number_coords)
    assert board.unique?(ordinal)
  end

  def test_are_coordinates_consecutive?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    split_coords = board.split_coordinates(cruiser, ["A2", "A3", "A4"])
    number_coords = board.store_number_coords(split_coords)
    letter_coords = board.store_letter_coords(split_coords)
    ordinal = board.convert_to_ordinals(letter_coords)
    assert board.consecutive?(number_coords)
    refute board.consecutive?(ordinal)
  end

  def test_coordinates_are_either_unique_or_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    split_coords = board.split_coordinates(cruiser, ["A2", "A3", "A4"])
    number_coords = board.store_number_coords(split_coords)
    letter_coords = board.store_letter_coords(split_coords)
    ordinal = board.convert_to_ordinals(letter_coords)
    unique_num = board.unique?(number_coords)
    unique_ord = board.unique?(ordinal)
    consecutive_num = board.consecutive?(number_coords)
    consecutive_ord = board.consecutive?(ordinal)

    assert_equal true, board.unique_or_consecutive(unique_ord, consecutive_num)
    assert_equal false, board.unique_or_consecutive(unique_num, consecutive_ord)
  end

  def test_valid_placement_for_consecutive_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_valid_placement_for_diagonal_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_you_can_place_ship_on_board
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert cell_3.ship == cell_2.ship
  end

  def test_ship_does_not_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
    assert_equal true, board.valid_placement?(submarine, ["B1", "B2"])
  end

  def test_split_horiz_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal [1, 2, 3, 4], board.split_horiz_coordinates
  end

  def test_split_vert_coordinates
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal ["A", "B", "C", "D"], board.split_vert_coordinates
  end

  def test_print_header
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    expected = "  1 2 3 4 \n"
    assert_equal expected, board.render_horizontal
  end

  def test_match_vertical_cells
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    # actual = board.match_vertical_cells[0].keys
    # expected = ["A1", "A2", "A3", "A4"]
    actual = board.match_vertical_cells
    binding.pry
    assert_equal expected, actual
  end

  def test_render_changes_as_fired_upon
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    board.cells["A1"].fire_upon
    actual = board.match_vertical_cells
    binding.pry
    assert_equal expected, actual
  end


  def test_the_board_renders
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, board.render
  end
end
