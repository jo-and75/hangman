# frozen_string_literal: true

require_relative 'word_guesser'
puts 'Game loaded'

class WordCreator
  def initialize(word_guesser)
    @desired_words = []
    @lines = File.open('google-10000-english-no-swears.txt', 'r').each do |line|
      word = line.to_s.strip
      @desired_words << word if word.length >= 5 && word.length < 13
    end
    @chosen_word = @desired_words.sample.split('')
    @board = Array.new(@chosen_word.length, '_') 
    @word_guesser = word_guesser 
    display_board(@board)
  end

  def display_board(board)
    board.each_with_index do |letter, index|
      if index == board.length - 1
        print "#{letter}"
      else
        print "#{letter}, "
      end
    end
    puts # This just moves to the next line after displaying the board 
  end 

  def analyze_guess
    if @chosen_word.include?(@word_guesser.letter_choice)
      puts 'YES'
    else
      puts 'NO'
    end 
    @word_guesser.guess_letter
  end
end
