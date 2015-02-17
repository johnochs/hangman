require_relative 'dictionary'
require_relative 'game'
require_relative 'player'
require_relative 'computer_player'

class HangmanGame

  def initialize
    keep_playing = true
    while keep_playing
      new_game
      puts "Would you like to play again? (y/n)"
      keep_playing = false unless gets.chomp == 'y'
    end
    system('clear')
    puts "Thanks for playing!"
  end

  def new_game
    print "Who is playing, a human or a computer? (type 'human' or 'computer'):"
    input = gets.chomp
    raise "Input Error" unless input == 'human' || input == 'computer'
  rescue
    puts "Input was not correct, try again."
    retry
  ensure
    input == 'human' ? human_game : computer_game
  end

  def human_game
    puts "What's your name?"
    name = gets.chomp
    player = (name.length > 0 ? Player.new(name) : Player.new)
    run_game(player)
  end

  def computer_game
    puts "What's the name of your computer?"
    name = gets.chomp
    d = Dictionary.new
    player = (name.length > 0 ? ComputerPlayer.new(d, name) : ComputerPlayer.new(d))
    run_game(player, d)
  end

  def run_game(player, dictionary = Dictionary.new)
    game = Game.new(player: player, dictionary: dictionary, quiet: false)
    game.start_game
  end

end

HangmanGame.new
