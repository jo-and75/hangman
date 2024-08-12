require_relative 'word_guesser'
puts 'Game loaded' 

class WordCreator 
  def initialize
    @desired_words = []
    @lines = File.open('google-10000-english-no-swears.txt', 'r').each do |line|
      word = line.to_s.strip
      @desired_words << word if word.length >= 5 && word.length < 13
    end
    puts @desired_words.sample 
    @word_guesser = WordGuesser.new
  end 

  def analyze_letter 

  end
end 

playGame = WordCreator.new