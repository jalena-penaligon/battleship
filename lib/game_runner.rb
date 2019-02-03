require_relative 'ship'
require_relative 'cell'
require_relative 'board'
require_relative 'game'

puts "Welcome to Battleship!\nEnter p to play. Enter q to quit."

input = gets.chomp
game = Game.new(input)

puts game
