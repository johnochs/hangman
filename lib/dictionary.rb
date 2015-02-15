class Dictionary

  attr_reader :words

  def initialize(path = "./lib/words.txt")
    @words = Hash.new { |h, k| h[k] = true }
    populate(path)
  end

  def has_word?(word)
    @words.has_key?(word)
  end

  def random_word
    @words.keys.sample
  end

  private

  def populate(path)
    File.open(path).each_line do |line|
      clean_word = line.strip.downcase
      next if clean_word.length == 0
      @words[clean_word]
    end
  end

end
