class Computer
  attr_accessor :code_key, :code_tracker, :skip
  def initialize
    @code_key = Hash.new
    @code_tracker = Hash.new { Array.new }
    @skip = Array.new
  end

  def handle_exact(code, idx)
    @code_key[idx] = code
  end

  def handle_tracker(indices)
    # @code_tracker[code] = ?|indices
  end

  def generate_guess
    guess = []
    (1..4).each do |idx|
      if code_key[idx]
        guess << code_key[idx]
      else
        tracked = track_code(idx)

        next if tracked

        code = random_code
        guess << code
      end
    end

    guess
  end

  def track_code(index)
    tracked = false
    code_tracker.each do |code, wrong_loc|
      unless wrong_loc.include?(idx)
        guess << code
        tracked = true
        break
      end
    end

    tracked
  end

  def random_code
    code = rand(1..6)
    until !skip.include?(code)
      code = rand(1..6)
    end
    code
  end
end