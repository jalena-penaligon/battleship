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
    game.player_setup(cruis_coords, sub_coords)

    actual = game.player_board.render(true).include?("S")
    assert_equal true, actual
  end


  # def test_computer_test_turn
  #   computer = Board.new
  #   player = Board.new
  #   game = Game.new(computer, player)
  #   guess = game.generate_random_coord
  #   actual = player.cells.keys.include?(guess)
  #
  #   assert_equal true, actual
  # end
  #
  #
  #
  # def test_computer_can_take_turns
  #   board = Board.new
  #   computer = Computer.new(board)
  #   player = Player.new(board)
  #   game = Game.new(computer, player)
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #
  #   computer.comp_placement(cruiser)
  #   computer.comp_placement(submarine)
  #   player.player_placement(cruiser, ["B2", "B3", "B4"])
  #   player.player_placement(submarine, ["C3", "D3"])
  #   game.computer_take_turn("D3")
  #
  #   actual = player.board.cells["D3"].fired_upon?
  #   assert_equal true, actual
  # end
  #
  # def test_player_can_take_turns
  #   board = Board.new
  #   computer = Computer.new(board)
  #   player = Player.new(board)
  #   game = Game.new(computer, player)
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #
  #   computer.comp_placement(cruiser)
  #   computer.comp_placement(submarine)
  #   player.player_placement(cruiser, ["B2", "B3", "B4"])
  #   player.player_placement(submarine, ["C3", "D3"])
  #   game.player_take_turn("D3")
  #
  #   actual = computer.board.cells["D3"].fired_upon?
  #   assert_equal true, actual
  # end

end
