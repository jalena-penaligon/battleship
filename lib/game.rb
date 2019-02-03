class Game
  attr_reader :comp_board,
              :user_board
  def initialize(comp_board, user_board)
    @comp_board = comp_board
    @user_board = user_board
  end

  def comp_placement(ship_type)
    keys = @comp_board.cells.keys
    select = ship_type.length
    random = []
    key_1 = keys.sample
    random << key_1
    key_index = keys.index(key_1)
    (select - 1).times do
      random << keys[key_index += 1]
    end
    loop do
      if @comp_board.valid_placement?(ship_type, random) == true
          random.each do |cell|
            @comp_board.cells[cell].place_ship(ship_type)
          end
        break
      else @comp_board.valid_placement?(ship_type, random) == false
        random = []
        key_1 = keys.sample
        random << key_1
        key_index = keys.index(key_1)
        (select - 1).times do
          random << keys[key_index += 1]
        end
        return random
      end
    end
  end
end
