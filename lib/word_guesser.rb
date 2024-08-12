class WordGuesser   
  attr_accessor :letter_choice
 
  def guess_letter  
    loop do
      print "Pick a letter from a-z: " 
      @letter_choice = gets.downcase.strip   
      if @letter_choice.between?('a','z') && @letter_choice.length == 1 
        break
      else 
       puts 'Invalid input' 
      end 
    end
  end

  def submit_guess 
    print 'Are you sure you want to submit this letter: ' 
    answer = gets.upcase.strip 
    if answer == 'YES' 
      return true 
    else 
      return false 
    end
  end 
end