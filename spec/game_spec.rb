require 'game'
require 'player'
require 'dictionary'

describe Game do

  subject(:game) do
    Game.new( Dictionary.new('./lib/test_words.txt'), Player.new)
  end

  subject(:dictionary) { Dictionary.new('./lib/test_words.txt') }

  subject(:player) { Player.new('Test Player') }

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

  describe '#start_game' do

    it 'picks a random word from its dictionary' do
      dict_double = double
      allow(dict_double).to receive(:random_word).and_return('helium')
      expect(dict_double).to receive(:random_word)
      game = Game.new(dict_double, Player.new)
      game.stub(:tick) { 'true' }
      game.start_game
    end
  end

  describe '#game_over?' do

    it 'returns false when player has < max # points && has not guessed secret' do
      player_double = double
      allow(player_double).to receive(:score).and_return(2)
      allow(player_double).to receive(:guessed_letters).and_return(['a', 'c'])
      expect(game.game_over?('cat')).to eq(false)
    end
  end

end
