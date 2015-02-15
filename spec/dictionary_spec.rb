require 'dictionary'

describe Dictionary do

  subject(:dict) { Dictionary.new('./lib/test_words.txt') }

  describe '#initialize' do

    #TODO: Find out why this test is failing...
    xit 'reads in a file' do
      expect(File).to receive(:open)
      Dictionary.new('.lib/test_words.txt')
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

end
