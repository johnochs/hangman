#A simple utility for importing a word list that may not be completely clean

input = File.open(ARGV[0])
output = File.new('words.txt', 'w')
count = 0
input.each_line do |line|
  line.force_encoding('US-ASCII')
  line.downcase!
  lc = ('a'..'z').to_a

  result = ""
  line.each_char do |c|
    result << c if lc.include?(c)
  end

  output.puts(result)
  count += 1
end

puts "#{count} words in file."
