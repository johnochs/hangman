require 'game'
require 'player'
require 'dictionary'

describe Game do

  subject(:game) do
    dict = Dictionary.new('./lib/test_words.txt')
    Game.new(dictionary: dict, player: Player.new)
  end

  subject(:dictionary) { Dictionary.new('./lib/test_words.txt') }

  subject(:player) { Player.new('Test Player') }

  describe '#initialize' do

    it 'can take custom dictionary and player as arguments' do
      cust_dict = Dictionary.new('./lib/test_words.txt')
      player = Player.new('John')
      game = Game.new(dictionary: cust_dict, player: player)
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
      game = Game.new(dictionary: dict_double, player: Player.new)
      game.stub(:tick) { true }
      game.stub(:game_over?) { true }
      game.start_game
    end
  end

  describe '#game_over?' do

    it 'returns false when player has < max # points && has not guessed secret' do
      player_double = double
      allow(player_double).to receive(:score).and_return(2)
      allow(player_double).to receive(:guessed_letters).and_return(['a', 'c'])
      allow(player_double).to receive(:guessed_words).and_return([])
      test_game = Game.new(dictionary: dictionary, player: player_double)
      expect(test_game.game_over?('cat')).to eq(false)
    end

    it 'immediately returns true if players score is >= max points' do
      player_double = double
      allow(player_double).to receive(:score).and_return(7)
      allow(player_double).to receive(:guessed_letters)
      allow(player_double).to receive(:guessed_words).and_return([])
      expect(player_double).not_to receive(:guessed_letters)
      expect(
        Game.new(dictionary: dictionary, player: player_double)
          .game_over?('nitrogen')
          ).to eq(true)
    end

    it 'returns true when the player has guessed all the letters of the secret word' do
      player_double = double
      allow(player_double).to receive(:guessed_letters).and_return(['r','l','a','e'])
      allow(player_double).to receive(:guessed_words).and_return([])
      allow(player_double).to receive(:score).and_return(2)
      expect(
        Game.new(dictionary: dictionary, player: player_double
        ).game_over?('real')).to eq(true)
    end

    it 'returns true for a variety of words' do
      ['ballet', 'tooth', 'christmas', 'markov', 'level'].each do |word|
        player_double = double
        allow(player_double).to receive(:guessed_words).and_return([])
        allow(player_double).to receive(:guessed_letters)
            .and_return(word.split('').uniq)
        allow(player_double).to receive(:score).and_return(1)
        expect(
          Game.new(dictionary: dictionary, player: player_double).game_over?(word)
          ).to eq(true)
      end
    end

    it 'returns true when a player guesses the correct word' do
      player_double = double
      allow(player_double).to receive(:guessed_words).and_return(
          ['tralfamadore', 'venus', 'pluto', 'earth']
        )
      allow(player_double).to receive(:score).and_return(2)
      game = Game.new(dictionary: dictionary, player: player_double)
      expect(game.game_over?('venus')).to eq(true)
    end
  end

  describe "#render" do

    it "displays an empty board properly" do
      player_double = double
      allow(player_double).to receive(:guessed_letters).and_return(['r','p','m'])
      game = Game.new(dictionary: dictionary, player: player_double)
      expect(game.render('scout')).to match(/_*/)
    end

    it 'displays a partially filled board properly' do
      player_double = double
      allow(player_double).to receive(:guessed_letters).and_return(['s','u','o'])
      game = Game.new(dictionary: dictionary, player: player_double)
      expect(game.render('scout')).to match(/s_ou_/)
    end

    it 'displays a fully filled board properly' do
      player_double = double
      allow(player_double).to receive(:guessed_letters).and_return(['s','u','o','c','t'])
      game = Game.new(dictionary: dictionary, player: player_double)
      expect(game.render('scout')).to match(/scout/)
    end
  end

  describe "#tick" do

    it 'gets player input' do
      player_double = double
      allow(player_double).to receive(:guess)
      allow(player_double).to receive(:right_answer)
      expect(player_double).to receive(:guess)
      game = Game.new(dictionary: dictionary, player: player_double)
      game.stub(:good_guess?) { true }
      game.stub(:render) { '____' }
      game.tick('someword')
    end

    context "with a good word or letter received from the player" do

      it 'calls player#right_answer (letter)' do
        player_double = double
        allow(player_double).to receive(:guess).and_return('c')
        allow(player_double).to receive(:right_answer)
        game = Game.new(dictionary: dictionary, player: player_double)
        expect(player_double).to receive(:right_answer)
        game.stub(:good_guess?) { true }
        game.stub(:render) { '____' }
        game.tick('cat')
      end

      it 'calls player#right_answer (word)' do
        player_double = double
        allow(player_double).to receive(:guess).and_return('cat')
        allow(player_double).to receive(:right_answer)
        game = Game.new(dictionary: dictionary, player: player_double)
        expect(player_double).to receive(:right_answer)
        game.stub(:good_guess?) { true }
        game.stub(:render) { '____' }
        game.tick('cat')
      end

    end

    context "with a bad word or letter received from the player" do

      it 'calls player#wrong_answer (letter)' do
        player_double = double
        allow(player_double).to receive(:guess).and_return('c')
        allow(player_double).to receive(:wrong_answer)
        game = Game.new(dictionary: dictionary, player: player_double)
        expect(player_double).to receive(:wrong_answer)
        game.stub(:good_guess?) { false }
        game.tick('bat')
      end

      it 'calls player#right_answer (word)' do
        player_double = double
        allow(player_double).to receive(:guess).and_return('cat')
        allow(player_double).to receive(:wrong_answer)
        game = Game.new(dictionary: dictionary, player: player_double)
        expect(player_double).to receive(:wrong_answer)
        game.stub(:good_guess?) { false }
        game.tick('bat')
      end

    end

  end

  describe '#good_guess?' do

    context 'with a good guess' do

      it 'returns true with a letter' do
        expect(game.good_guess?('cat', 'a')).to eq(true)
      end

      it 'returns true with a word' do
        expect(game.good_guess?('hat', 'hat')).to eq(true)
      end

    end

    context 'with a bad guess' do

      it 'returns false with a letter' do
        expect(game.good_guess?('hue', 'b')).to eq(false)
      end

      it 'returns false with a word' do
        expect(game.good_guess?('coat', 'boat')).to eq(false)
      end

    end

  end

end
