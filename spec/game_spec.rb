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

    it 'will default to standard dictionary and default human player if no args passed' do
      game = Game.new
      player_name = Player.new.name
      expect(game.dictionary.has_word?('aratherunorthodoxword')).to eq(false)
      expect(game.player.name).to eq(player_name)
    end
  end

end
