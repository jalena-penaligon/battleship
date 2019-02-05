require_relative 'ship'
require_relative 'cell'
require_relative 'board'
require_relative 'game'

puts "Welcome to Battleship!\nEnter p to play. Enter q to quit."
comp_board = Board.new
user_board = Board.new
game = Game.new(comp_board, user_board)
cruiser = Ship.new("Cruiser", 3)

user_input = gets.chomp
game.user_placement(cruiser, user_input)


#get to game = Game.new
#game.start = method that starts game
#all object creation happens after this point. (initialize)
