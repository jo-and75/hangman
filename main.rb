# frozen_string_literal: true

require 'yaml'
require_relative 'lib/word_creator'
require_relative 'lib/word_guesser'

class Game
  def initialize
    @word_guesser = WordGuesser.new
    @word_creator = WordCreator.new(@word_guesser)
    play_game
  end

  def save_state
    YAML.dump(
      'turns_left' => @word_creator.turns_left,
      'chosen_word' => @word_creator.chosen_word,
      'board' => @word_creator.board,
      'incorrect_guesses' => @word_creator.incorrect_guesses
    )
  end

  def play_game
    puts 'Do you want to load a saved game? (yes/no)'
    if gets.downcase.strip == 'yes'
      puts 'Enter the filename (without extension):'
      filename = gets.strip
      load_game(filename)
    end
    loop do
      @word_guesser.guess_letter
      @word_creator.analyze_guess if @word_guesser.submit_guess == true
      if (@word_creator.turns_left % 6).zero?
        print 'Type yes or no if you would like to save game: '
        save_game if gets.downcase.strip == 'yes'
      end
      break if end_game
      # load_saved_state
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
    Dir.mkdir('saved_games') unless Dir.exist? 'saved_games'
    filename = "#{rand(1000..9999)}_game.yaml"
    File.open("saved_games/#{filename}", 'w') { |file| file.write save_state }
    puts "Game saved as #{filename}"
  end

  # def read_game_file
  #   @file_lines = File.open('saved_games/8367_game.yaml', 'r').each do |line|
  #     puts line
  #   end
  # end

  def load_game(filename)
    if File.exist?("saved_games/#{filename}_game.yaml")
      saved_data = YAML.load_file("saved_games/#{filename}_game.yaml")
      @word_creator.turns_left = saved_data['turns_left']
      @word_creator.chosen_word = saved_data['chosen_word']
      @word_creator.board = saved_data['board']
      @word_creator.incorrect_guesses = saved_data['incorrect_guesses']
      puts 'Game Loaded'
    else
      puts 'File not found'
    end
  end
end

Game.new
