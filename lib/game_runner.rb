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

  comp_health = game.health(game.computer_board)
  player_health = game.health(game.player_board)
  # comp_guess = []
  player_guess = []

  while comp_health != 0 && player_health != 0
    puts "=============COMPUTER BOARD============="
    puts game.computer_board.render
    puts "==============PLAYER BOARD=============="
    puts game.player_board.render(true)

    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.to_s

    loop do
      if game.computer_board.cells.keys.include?(coordinate) == false
        puts "That was an incorrect coordinate. Please enter a valid coordinate:"
        coordinate = gets.chomp.to_s
      elsif player_guess.include?(coordinate)
        puts "You already guessed that coordinate! Please choose another."
        coordinate = gets.chomp.to_s
      else
        break
      end
    end

    game.turn(coordinate)
    player_guess << coordinate

    comp_health = game.health(game.computer_board)
    player_health = game.health(game.player_board)
    game.end_game
  end
else
  puts "You have quit the game."
end
