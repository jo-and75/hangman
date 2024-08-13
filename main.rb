# frozen_string_literal: true

require_relative 'lib/word_creator'
require_relative 'lib/word_guesser'
require_relative 'lib/Serializable'
class Game
  include Serializable

  def initialize
    @word_guesser = WordGuesser.new
    @word_creator = WordCreator.new(@word_guesser)
    play_game
  end

  def to_json(*_args)
    serialize
  end

  def play_game
    loop do
      @word_guesser.guess_letter
      @word_creator.analyze_guess if @word_guesser.submit_guess == true
      if (@word_creator.turns_left % 6).zero?
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
      file.write(to_json)
    end
    puts 'Game saved'
    exit
  end

  def self.load_game
    game = new
    File.open('lib/Game.json', 'r') do |file|
      json_data = file.read
      game.unserialize(json_data)
    end
    game
  end
end

Game.new
