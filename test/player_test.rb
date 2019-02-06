require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require 'pry'

class PlayerTest < Minitest::Test
  def test_player_exists
    computer_board = Board.new
    player_board = Board.new
    player = Player.new(player_board, computer_board)

    assert_instance_of Player, player
  end

  def test_input_coordinates_must_have_valid_placement
    computer_board = Board.new
    player_board = Board.new
    player = Player.new(player_board, computer_board)
    cruiser = Ship.new("Cruiser", 3)
    input_coords = ["D1", "D2", "D3"]

    assert_equal true, player.validate_input_placement(cruiser, input_coords)
    input_coords = ["D1", "C2", "D3"]

    assert_equal false, player.validate_input_placement(cruiser, input_coords)
  end

  def test_player_ship_placement
    computer_board = Board.new
    player_board = Board.new
    player = Player.new(player_board, computer_board)
    cruiser = Ship.new("Cruiser", 3)
    input_coords = ["A1", "B1", "C1"]
    player.validate_input_placement(cruiser, input_coords)
    player.player_placement(cruiser, input_coords)
    actual = player_board.render(true).include?("S")
    assert_equal true, actual
  end

  def test_player_takes_turn
    computer_board = Board.new
    player_board = Board.new
    player = Player.new(player_board, computer_board)
    player.take_turn("B4")

    assert_equal true, computer_board.cells["B4"].fired_upon?
  end
end
