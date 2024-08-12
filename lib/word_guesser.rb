class WordGuesser
  attr_accessor :letter_choice

  def guess_letter
    loop do
      print 'Pick a letter from a-z: '
      @letter_choice = gets.downcase.strip
      break if @letter_choice.between?('a', 'z') && @letter_choice.length == 1

      puts 'Invalid input'
    end
  end

  def submit_guess
    print 'Are you sure you want to submit this letter: '
    answer = gets.upcase.strip
    answer == 'YES'
  end
end
