class Dictionary

  attr_reader :words

  def initialize(path = "./lib/words.txt")
    @words = Hash.new { |h, k| h[k] = true }
    populate(path)
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
