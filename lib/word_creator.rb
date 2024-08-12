# frozen_string_literal: true

require_relative 'word_guesser'
puts 'Game loaded'

class WordCreator
  attr_accessor :turns_left, :chosen_word, :board

  def initialize(word_guesser)
    @desired_words = []
    @turns_left = 11
    @incorrect_guesses = []
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
    @turns_left -= 1
    letter_positions = []
    if @chosen_word.include?(@word_guesser.letter_choice)
      @chosen_word.each_with_index do |letter, index|
        letter_positions << index if letter == @word_guesser.letter_choice
      end
      letter_positions.each do |element|
        @board[element] = @word_guesser.letter_choice
      end
    else
      @incorrect_guesses << @word_guesser.letter_choice
      puts 'Chosen letter is not in word. Please try again.'

    end
    print @incorrect_guesses
    puts # resets position of cursor
    display_board(@board)
    puts "You have #{@turns_left} tries left."
  end
end
