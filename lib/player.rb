class Player

  attr_reader :name, :score, :guessed_letters, :guessed_words

  def initialize(name = "Bob")
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
