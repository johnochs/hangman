require_relative('player')
require_relative('dictionary')

class Game

  POINTS_TO_END_GAME = 5

  attr_reader :dictionary, :player

  def initialize(dictionary = Dictionary.new, player = Player.new)
    @dictionary = dictionary
    @player = player
  end

  def start_game
    secret_word = @dictionary.random_word

    until game_over?(secret_word)
      tick
    end
  end

  def game_over?(secret_word)
    return true if @player.score >= POINTS_TO_END_GAME
    letter_arr = secret_word.split('').uniq
    (letter_arr & @player.guessed_letters).size == letter_arr.size
  end

end
