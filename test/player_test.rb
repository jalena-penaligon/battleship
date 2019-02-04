require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/player'
require 'pry'

class PlayerTest < Minitest::Test
  def test_player_exists
      board = Board.new
      player = Player.new(board)

      assert_instance_of Player, player
  end

  def test_input_coordinates_must_have_valid_placement
    board = Board.new
    player = Player.new(board)
    cruiser = Ship.new("Cruiser", 3)
    input_coords = ["D1", "D2", "D3"]

    assert_equal true, player.validate_input_placement(cruiser, input_coords)
    input_coords = ["D1", "C2", "D3"]

    assert_equal false, player.validate_input_placement(cruiser, input_coords)
  end

  def test_player_ship_placement
    board = Board.new
    player = Player.new(board)
    cruiser = Ship.new("Cruiser", 3)
    input_coords = ["A1", "B1", "C1"]
    player.validate_input_placement(cruiser, input_coords)
    player.player_placement(cruiser, input_coords)
    actual =  board.render(true).include?("S")
    assert_equal true, actual
  end
end
