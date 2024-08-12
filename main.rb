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
      break if end_game
    end
  end

  def end_game
    if @word_creator.chosen_word == @word_creator.board
      puts 'GAME OVER. YOU WIN!! :)'
      true
    elsif @word_creator.turns_left.zero?
      if @word_creator.chosen_word == @word_creator.board
        puts 'GAME OVER. YOU WIN!! :)'
        true
      else
        puts 'GAME OVER. YOU LOSE :('
        true
      end
    end
  end
end

play = StartGame.new
