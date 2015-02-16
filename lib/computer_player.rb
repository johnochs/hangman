class ComputerPlayer

  attr_reader :name, :score, :guessed_letters, :guessed_words

  def initialize(dictionary, name = "Computer")
    @name = name
    @dictionary = dictionary
    @score = 0
    @guessed_letters = []
    @guessed_words = []
  end

  def guess
    input = find_best_letter

    input.length == 1 ? add_letter(input) : add_word(input)

    input
  end

  def register_word_length(length)
    @filter = create_regexp('_' * length)
    @possible_words = @dictionary.words.delete_if { |k, v| k.length != length }
  end

  def wrong_answer
    @score < 4 ? @score += 1 : @score = 25
    @bad_letter = Regexp.new(@guessed_letters.last)
  end

  def right_answer(board)
    @filter = create_regexp(board)
  end

  private

  def add_letter(letter)
    @guessed_letters << letter unless @guessed_letters.include?(letter)
  end

  def create_regexp(board)
    result_string = ""
    board.each_char do |c|
      result_string << (c == "_" ? '.' : c)
    end
    Regexp.new(result_string)
  end

  def find_best_letter
    filter_words
    letter_frequencies = Hash.new(0)
    @possible_words.each_key do |k|
      k.each_char { |c| letter_frequencies[c] += 1 }
    end

    best_letter, highest_frequency = 'a', 0
    letter_frequencies.each_pair do |k, v|
      next if @guessed_letters.include?(k)
      best_letter, highest_frequency = k, v if v > highest_frequency
    end

    best_letter
  end

  def filter_words
    @possible_words.delete_if do |k, v|
      @filter.match(k).nil? || (@bad_letter && @bad_letter.match(k))
    end
    @bad_letter = nil
  end

end
