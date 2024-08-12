class WordGuesser   
  attr_accessor :letter_choice
  def initialize(word_creator) 
    @word_creator = word_creator
    guess_letter
  end 
  
  def guess_letter  
    loop do
      print "Pick a letter from a-z: " 
      @letter_choice = gets.downcase.strip   
      if @letter_choice.between?('a','z') && @letter_choice.length == 1
        submit_guess  
        break
      else 
       puts 'Invalid input' 
      end 
    end
  end

  def submit_guess 
    print 'Are you sure you want to submit this letter: ' 
    answer = gets.upcase.strip 
    puts answer
  end 
end