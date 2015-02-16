#Keeping in mind: public API for Player will later need to be identical
#to the one for the AI player.

class Player

  attr_reader :name, :score, :guessed_letters, :guessed_words

  def initialize(name = "Human")
    @name = name
    @score = 0
    @guessed_letters = []
    @guessed_words = []
  end

  def guess
    input = gets.chomp.downcase

    if valid_guess?(input)
      input.length == 1 ? add_letter(input) : add_word(input)
    else
      raise "That ain't no word and it ain't no letter neither!"
    end

    input
  end

  def register_word_length(length)
  end

  def wrong_answer
    @score < 4 ? @score += 1 : @score = 25
  end

  def right_answer(board)
  end

  private

  LETTERS = ('a'..'z').to_a

  def valid_guess?(input)
    input.each_char do |char|
      return false unless LETTERS.include?(char)
    end
    true
  end

  def add_letter(letter)
    @guessed_letters = @guessed_letters | [ letter ]
  end

  def add_word(word)
    @guessed_words = @guessed_words | [ word ]
  end
end
