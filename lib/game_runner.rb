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

  cruis_coords = game.collect_player_input_cruis
  loop do
    if game.player_setup_cruiser(cruis_coords) == false
      puts "Sorry, those were incorrect coordinates. Try again!"
      cruis_coords = game.collect_player_input_cruis
    else
      break
    end
  end

  sub_coords = game.collect_player_input_sub
  loop do
    if game.player_setup_submarine(sub_coords) == false
      puts "Sorry, those are incorrect coordinates. Try again!"
      sub_coords = game.collect_player_input_sub
    else
      break
    end
  end

  comp_health = game.health(game.computer_board)
  player_health = game.health(game.player_board)

  player_guess = []

  while comp_health != 0 && player_health != 0
    game.render_boards

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
