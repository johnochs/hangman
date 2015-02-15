require 'game'
require 'player'
require 'dictionary'

describe Game do

  describe '#initialize' do

    it 'can take custom dictionary and player as arguments' do
      cust_dict = Dictionary.new('./lib/test_words.txt')
      player = Player.new('John')
      game = Game.new(cust_dict, player)
      expect(game.dictionary.has_word?('aratherunorthodoxword')).to eq(true)
      expect(game.player.name).to eq('John')
    end
    
  end

end
