require 'player'

describe Player do

  describe "#initialize" do

    subject(:player) { Player.new }

    it "will allow for a name to be designated" do
      john = Player.new('John')
      expect(john.name).to eq('John')
    end

    it "will provide a default name if no name is specificed" do
      expect(player.name).to be_kind_of(String)
    end

    it "generates a default initial score of zero" do
      expect(player.score).to eq(0)
    end

  end

end
