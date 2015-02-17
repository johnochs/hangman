require 'dictionary'

describe Dictionary do

  subject(:dict) { Dictionary.new('./lib/test_words.txt') }
  cur_dir = Dir.pwd
  describe '#initialize' do

    it 'reads in a file' do
      dict = Dictionary.new("./lib/test_words.txt")
      expect(dict.has_word?('aratherunorthodoxword')).to eq(true)
    end

    it 'initializes a hash to contain the words' do
      expect(dict.words).to be_kind_of(Hash)
    end

    it 'does not include empty strings in the dictionary' do
      expect(dict.words.has_key?('')).to eq(false)
    end

    it 'cleans data so it only contains lower-cased words' do
      expect(dict.words.keys.all? { |w| w.downcase == w }).to eq(true)
    end
  end

  describe '#has_word?' do

    it 'returns true if word is in dictionary' do
      expect(dict.has_word?('cat')).to eq(true)
    end

    it 'returns false if word is not in dictionary' do
      expect(dict.has_word?('kitty')).to eq(false)
    end
  end

  describe '#random_word' do

    #TODO: There should probably be a more statistically oriented way to do this
    it 'all words are accessible' do
      d = dict
      sampled_words = Hash.new { |h,k| h[k] = true}

      1000.times do
        sampled_words[d.random_word]
      end

      expect(d.words.keys.size).to eq(sampled_words.keys.size)
    end
  end

end
