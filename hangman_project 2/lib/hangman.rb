class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end
  
  def get_matching_indices(char)
    arr = []
    @secret_word.each_char.with_index { |c, i| arr << i if c == char }
    arr
  end

  def fill_indices(char, arr)
    arr.each { |index| @guess_word[index] = char }
  end

  def try_guess(char)
    if already_attempted?(char)
      puts "that has already been attempted"
      false
    else
      @attempted_chars << char
      if !@secret_word.include?(char)
        @remaining_incorrect_guesses -= 1
      else
        fill_indices(char, get_matching_indices(char))
      end
      true
    end
  end

  def ask_user_for_guess
    puts "Enter a char:"
    try_guess(gets.chomp)
  end

  def win?
    if @guess_word.join == @secret_word
      puts "WIN"
      return true
    end
    false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end
    false
  end

  def game_over?
    if win? || lose?
      puts @secret_word
      return true
    end
    false
  end
end
