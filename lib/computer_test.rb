require_relative('game')

scores = []
no_times = 100
dict = Dictionary.new

no_times.times do
  cp = ComputerPlayer.new(dict)
  game = Game.new(player: cp, dictionary: dict, quiet: true)
  game.start_game
  scores << cp.score
end

average = scores.inject(:+).to_f / no_times

puts "Average score for #{no_times} games: #{average}."
