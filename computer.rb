class Computer
  attr_accessor :correct, :previous_guesses, :skip
  def initialize
    @correct = Array.new(4, nil) 
    @previous_guesses = []
    @skip = []
  end

  def handle_correct(value, guess)
    guess == value
  end

  def correct_counter
    valid_nums = correct.select { |n| n }
    valid_nums.count
  end

  def incorrect_counter(guess)
    count = 0
    guess.each_with_index do |val, idx| 
      count += 1 unless val = correct[idx] || skip.include?(val)
    end
    count
  end


  def handle_skip(code_vals, guess)
    skip.include?(guess) || code_vals.include?(guess)
  end

  def check(game_code, guess)
    code_vals = game_code.map { |color| color[:val] }
    guess.each_with_index do |val, idx|
      @correct[idx] = val if handle_correct(code_vals[idx], val)
      @skip << val unless handle_skip(code_vals, val)
    end
  end

  def generate_guess
    new_guess = Array.new(4, nil)
    loop do
      (0..3).each do |idx|
        if correct[idx]
          new_guess[idx] = correct[idx]
        else
          num = random_code
          new_guess[idx] = num
        end
      end

      break unless previous_guesses.include?(new_guess)
    end

    previous_guesses << new_guess
    new_guess
  end

  def random_code
    new_code = rand(1..6)
    until !skip.include?(new_code)
      new_code = rand(1..6)
    end
    new_code
  end

  def clear_data
    @correct = Array.new(4, nil) 
    @incorrect = Hash.new { Array.new }
    @skip = Array.new
  end
end