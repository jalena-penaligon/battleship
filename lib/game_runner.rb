require_relative 'ship'
require_relative 'cell'
require_relative 'board'
require_relative 'game'
require_relative 'computer'
require_relative 'player'

game = Game.new
puts "Welcome to Battleship!\nEnter p to play. Enter q to quit."
start_game = gets.chomp

if start_game == "p"
  game.start
end

puts "I have laid out my ships on the grid."
puts "You now need to lay out your two ships."
puts "The Cruiser is two units long and the Submarine is three units long."

puts "==============PLAYER BOARD=============="
puts game.player_board.render

puts "Enter the squares for the Cruiser (3 spaces):"
puts "Square 1:"
cruis_coords = []
square = gets.chomp.to_s
cruis_coords << square
puts "Square 2:"
square = gets.chomp.to_s
cruis_coords << square
puts "Square 3:"
square = gets.chomp.to_s
cruis_coords << square

loop do
  if game.player_setup_cruiser(cruis_coords) == false
    puts "Sorry, those are incorrect coordinates. Try again!"
    puts "Square 1:"
    cruis_coords = []
    square = gets.chomp.to_s
    cruis_coords << square
    puts "Square 2:"
    square = gets.chomp.to_s
    cruis_coords << square
    puts "Square 3:"
    square = gets.chomp.to_s
    cruis_coords << square
  else
    break
  end
end

puts "==============PLAYER BOARD=============="
puts game.player_board.render(true)

puts "Enter 2 consecutive coordinates for your submarine."
puts "Square 1:"
sub_coords = []
square = gets.chomp.to_s
sub_coords << square
puts "Square 2:"
square = gets.chomp.to_s
sub_coords << square


loop do
  if game.player_setup_submarine(sub_coords) == false
    puts "Sorry, those are incorrect coordinates. Try again!"
    puts "Square 1:"
    sub_coords = []
    square = gets.chomp.to_s
    sub_coords << square
    puts "Square 2:"
    square = gets.chomp.to_s
    sub_coords << square
  else
    break
  end
end

puts "==============PLAYER BOARD=============="
puts game.player_board.render(true)


#get to game = Game.new
#game.start = method that starts game
#all object creation happens after this point. (initialize)
