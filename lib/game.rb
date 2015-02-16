require_relative('player')
require_relative('dictionary')
require_relative('computer_player')

class Game

  POINTS_TO_END_GAME = 5

  attr_reader :dictionary, :player

  def initialize(dictionary = Dictionary.new, player = Player.new)
    @dictionary = dictionary
    @player = player
  end

  def start_game
    secret_word = @dictionary.random_word
    @player.register_word_length(secret_word.length)
    system('clear')
    puts "Welcome to Hangman, #{@player.name}!"

    until game_over?(secret_word)
      puts ""
      puts "Your guessed words: " +
        (@player.guessed_words.empty? ? "None yet." : @player.guessed_words.join(', '))
      puts "Your guessed letters: " +
        (@player.guessed_letters.empty? ? "None yet." : @player.guessed_letters.join(', '))
      puts "Your score: " + @player.score.to_s
      puts "Board: " + render(secret_word)
      tick(secret_word)
    end

    puts
    if @player.score < 5
      puts "Congratulations, #{@player.name}!  You won!"
    else
      puts "Sorry, #{@player.name}.  This just wasn't your game."
    end
    puts "Final Score: #{@player.score}"
    puts "Word: #{secret_word}"
  end

  def game_over?(secret_word)
    return true if @player.score >= POINTS_TO_END_GAME
    return true if @player.guessed_words.include?(secret_word)
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
    print "Enter your guess (word or letter): "
    guess = @player.guess
    system('clear')
    if good_guess?(secret_word, guess)
      puts "Good guess!"
      @player.right_answer(render(secret_word))
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
