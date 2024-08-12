puts 'Game loaded'
desired_words = []
lines = File.open('google-10000-english-no-swears.txt', 'r')
lines.each do |line|
  word = line.to_s.strip
  desired_words << word if word.length >= 5 && word.length < 13
end

puts desired_words.sample
