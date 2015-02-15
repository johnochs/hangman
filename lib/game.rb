require_relative('player')
require_relative('dictionary')

class Game

  attr_reader :dictionary, :player

  def initialize(dictionary = Dictionary.new, player = Player.new)
    @dictionary = dictionary
    @player = player
  end
end
