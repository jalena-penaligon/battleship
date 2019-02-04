require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test
  def test_game_exists
    computer = Computer.new
    player = Player.new
    game = Game.new(comp_board, user_board)


    assert_instance_of Game, game
  end
end
