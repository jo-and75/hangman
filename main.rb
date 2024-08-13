# frozen_string_literal: true

require 'json'
require_relative 'lib/word_creator'
require_relative 'lib/word_guesser'

class Game
  def initialize
    @word_guesser = WordGuesser.new
    @word_creator = WordCreator.new(@word_guesser)
    play_game
  end

  def to_json(*_args)
    {
      # word_guesser: @word_guesser,
      word_creator: @word_creator
    }.to_json
  end

  def play_game
    loop do
      @word_guesser.guess_letter
      @word_creator.analyze_guess if @word_guesser.submit_guess == true
      if (@word_creator.turns_left % 7).zero?
        print 'Type yes or no if you would like to save game: '
        save_game if gets.downcase.strip == 'yes'
      end
      break if end_game
    end
  end

  def end_game
    if @word_creator.chosen_word == @word_creator.board
      puts 'GAME OVER. YOU WIN!! :)'
      true
    elsif @word_creator.turns_left.zero?
      puts "Correct word was: #{@word_creator.chosen_word.join}"
      puts 'GAME OVER. YOU LOSE :('
      true
    else
      false
    end
  end

  def save_game
    File.open('lib/Game.json', 'w') do |file|
      file.write(JSON.dump(self))
    end
    puts 'Game saved'
    exit
  end
end

Game.new
