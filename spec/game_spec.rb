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
      game.stub(:game_over?) { 'true' }
      game.start_game
    end
  end

  describe '#game_over?' do

    it 'returns false when player has < max # points && has not guessed secret' do
      player_double = double
      allow(player_double).to receive(:score).and_return(2)
      allow(player_double).to receive(:guessed_letters).and_return(['a', 'c'])
      test_game = Game.new(dictionary, player_double)
      expect(test_game.game_over?('cat')).to eq(false)
    end

    it 'immediately returns true if players score is >= max points' do
      player_double = double
      allow(player_double).to receive(:score).and_return(7)
      allow(player_double).to receive(:guessed_letters)
      expect(player_double).not_to receive(:guessed_letters)
      expect(Game.new(dictionary, player_double).game_over?('nitrogen')).to eq(true)
    end

    it 'returns true when the player has guessed all the letters of the secret word' do
      player_double = double
      allow(player_double).to receive(:guessed_letters).and_return(['r','l','a','e'])
      allow(player_double).to receive(:score).and_return(2)
      expect(Game.new(dictionary, player_double).game_over?('real')).to eq(true)
    end

    it 'returns true for a variety of words' do
      ['ballet', 'tooth', 'christmas', 'markov', 'level'].each do |word|
        player_double = double
        allow(player_double).to receive(:guessed_letters)
            .and_return(word.split('').uniq)
        allow(player_double).to receive(:score).and_return(1)
        expect(Game.new(dictionary, player_double).game_over?(word)).to eq(true)
      end
    end
  end

  describe "#render" do

    it "displays an empty board properly" do
      player_double = double
      allow(player_double).to receive(:guessed_letters).and_return(['r','p','m'])
      game = Game.new(dictionary, player_double)
      expect(game.render('scout')).to match(/_*/)
    end

    it 'displays a partially filled board properly' do
      player_double = double
      allow(player_double).to receive(:guessed_letters).and_return(['s','u','o'])
      game = Game.new(dictionary, player_double)
      expect(game.render('scout')).to match(/s_ou_/)
    end

    it 'displays a fully filled board properly' do
      player_double = double
      allow(player_double).to receive(:guessed_letters).and_return(['s','u','o','c','t'])
      game = Game.new(dictionary, player_double)
      expect(game.render('scout')).to match(/scout/)
    end
  end

  describe "#tick" do

    it 'gets player input' do
      player_double = double
      allow(player_double).to receive(:guess)
      expect(player_double).to receive(:guess)
      game = Game.new(dictionary, player_double)
      game.tick
    end

  end

end
