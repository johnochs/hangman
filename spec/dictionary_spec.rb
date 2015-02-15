require 'dictionary'

describe Dictionary do

  describe '#initialze' do

    subject(:dict) { Dictionary.new('./lib/test_words.txt') }

    #TODO: Find out why this test is failing...
    it 'reads in a file' do
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

end
