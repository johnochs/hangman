require 'player'

describe Player do

  describe "#initialize" do
    it "will allow for a name to be designated" do
      player = Player.new('John')
      expect(player.name).to eq('John')
    end
  end

end
