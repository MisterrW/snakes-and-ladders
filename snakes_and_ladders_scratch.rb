# counter = 0
# while counter <= 5
# thing = gets.chomp
# puts "player 1's turn!"
# thing = gets.chomp
# puts "player 2's turn!"

# counter += 1
# end

class Player
  attr_reader :name
  attr_accessor :current_position
  def initialize(name)
    @name = name
    @current_position = 1
  end
end

class Board
  def initialize()
    # @players = players
    @board_length = 64
    @snakes_ladders_hash = {
      3 => 45,
      48 => 32,
      56 => 2,
      23 => 14,
    }
  end

  def roll
    return (rand(6)+1)
    
  end

  def move
    for player in @players
      puts "#{player.name}'s turn! Press enter to roll!"
      gets.chomp
      result = roll()
      puts "You have rolled a #{result}"
      player.current_position += result
      if player.current_position >= 64
        player.current_position = 64 - (player.current_position-64)
      end
      puts "#{player.name}, you are on square #{player.current_position}"
      @snakes_ladders_hash.each do |key, value|
        if player.current_position == key
          puts "Uh-oh! You've hit a snake or a ladder. Up or down...?"
          new_position = value
          change = new_position - key
          puts "You have moved by #{change} places"
          player.current_position = new_position
          puts "Your new position is #{player.current_position}"
        end
      end
    win_check()
  end

  def win_check()
    for player in @players
      if player.current_position == 64
        puts "#{player.name} has won!"
        @players = []
        new_game()
      else
        move()
      end
    end
  end

  def new_game()
    puts "how many players?"
    player_num = gets.chomp.to_i
    @players = Array.new(player_num, "x")
    @players.each_with_index do |x, y|
      puts "set up player. Name?"
      name = gets.chomp
      @players[y] = Player.new(name)
    end
    # puts @players
    move()
  end

end

my_game = Board.new
my_game.new_game()