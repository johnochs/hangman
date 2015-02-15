require 'dictionary'

describe Dictionary do

  describe '#initialze' do

    subject(:dict) { Dictionary.new('./test_words') }

    it 'reads in a file' do
      expect(File).to receive(:open)
      Dictionary.new('./test_words')
    end

    it 'initializes a hash to contain the words' do
      expect(dict.words).to be_kind_of(Hash)
    end

    it 'does not include empty strings in the dictionary' do
      expect(dict.words.has_key?('')).to be_false
    end

    it 'cleans data so it only contains lower-cased words' do
      expect(dict.words.keys.all? { |w| w.downcase == w }).to be_true
    end
  end
end
