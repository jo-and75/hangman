# frozen_string_literal: true

require_relative 'lib/word_creator'
require_relative 'lib/word_guesser'

class StartGame
  def initialize
    @word_guesser = WordGuesser.new
    @word_creator = WordCreator.new(@word_guesser) 
    play_game
  end 

  def play_game  
    loop do 
      @word_guesser.guess_letter 
      @word_creator.analyze_guess if @word_guesser.submit_guess == true  
    end
  end 
end
 
play = StartGame.new
