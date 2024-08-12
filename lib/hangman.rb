puts 'Game loaded' 

lines = File.open('google-10000-english-no-swears.txt', 'r') 
lines.each do |line| 
  puts line 
end
