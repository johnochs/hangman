#A simple test for measuring the average score for a computer player.
require_relative('game')

scores = []
no_times = 1000
count = 0
dict = Dictionary.new

no_times.times do
  cp = ComputerPlayer.new(dict)
  game = Game.new(player: cp, dictionary: dict, quiet: true)
  game.start_game
  scores << cp.score
  count += 1
  puts "#{count} tests completed." if (count % 10 == 0)
end

average = scores.inject(:+).to_f / no_times

puts "Average score for #{no_times} games: #{average}."
