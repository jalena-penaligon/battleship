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
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_has_a_player
    game = Game.new

    assert_equal Player, game.player.class
  end


  def test_it_has_a_computer
    game = Game.new

    assert_equal Computer, game.computer.class
  end

  def test_it_has_a_player_board
    game = Game.new

    assert_equal Board, game.player_board.class
  end

  def test_it_has_a_computer_board
    game = Game.new

    assert_equal Board, game.computer_board.class
  end

  def test_start_places_computer_ships
    game = Game.new
    game.start

    assert_equal true, game.computer_board.render(true).include?("S")
  end

  def test_player_setup_places_ships
    game = Game.new
    cruis_coords = ["A1", "B1", "C1"]
    sub_coords = ["B3", "B4"]
    game.player_setup_cruiser(["A1", "A2", "A3"])
    game.player_setup_submarine(["C1", "C2"])

    actual = game.player_board.render(true).include?("S")
    assert_equal true, actual
  end

  def test_board_health
    game = Game.new
    computer_board = Board.new
    player_board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    computer_board.place(cruiser, ["A1", "A2", "A3"])
    computer_board.place(submarine, ["C1", "C2"])
    player_board.place(cruiser, ["B1", "B2", "B3"])
    player_board.place(submarine, ["D1", "D2"])

    assert_equal 13, game.health(player_board)
    assert_equal 13, game.health(computer_board)
  end

  def test_game_takes_turns
    game = Game.new
    game.start
    game.player_setup_cruiser(["A1", "A2", "A3"])
    game.player_setup_submarine(["C1", "C2"])
    game.turn("B4")

    assert_equal true, game.player_board.render.include?("M") || game.player_board.render.include?("H")
    assert_equal true, game.computer_board.render.include?("M") || game.computer_board.render.include?("H")
  end

  def test_player_feedback
    game = Game.new
    game.start
    game.player_setup_cruiser(["A1", "A2", "A3"])
    game.player_setup_submarine(["C1", "C2"])

    assert_equal String, game.turn("B4").class
  end
end
