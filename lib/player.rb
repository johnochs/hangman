class Player

  attr_reader :name, :score

  def initialize(name = "Bob")
    @name = name
    @score = 0
  end

end
