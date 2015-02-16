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
    puts "Welcome to Hangman!"

    until game_over?(secret_word)
      puts "Your guessed words: "
      print @player.guessed_words.empty? ? "None yet." : @player.guessed_words.join(' ')
      puts "Your guessed letters: "
      print @player.guessed_letters.empty? ? "None yet." : @player.guessed_letters.join(' ')
      puts "Your score: " + @player.score.to_s
      puts "Board: " + render(secret_word)
      tick(secret_word)
    end

    if @player.score < 5
      puts "Congratulations!  You won!"
    else
      puts "Sorry.  This just wasn't your game.  The word was #{secret_word}"
    end
  end

  def game_over?(secret_word)
    return true if @player.score >= POINTS_TO_END_GAME
    letter_arr = secret_word.split('').uniq
    (letter_arr & @player.guessed_letters).size == letter_arr.size
  end

  def render(secret_word)
    result_string = ""

    secret_word.each_char do |c|
      if @player.guessed_letters.include?(c)
        result_string << c
      else
        result_string << '_'
      end
    end
    result_string
  end

  def tick(secret_word)
    puts "Enter your guess (word or letter): "
    guess = @player.guess
    if good_guess?(secret_word, guess)
      puts "Good guess!"
      @player.right_answer
    else
      puts "Nope. :("
      @player.wrong_answer
    end
  end

  def good_guess?(secret_word, guess)
    if guess.length > 1
      secret_word == guess
    else
      secret_word.index(guess).nil? ? false : true
    end
  end

end
