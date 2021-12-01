require_relative 'colors'
require_relative 'hint'
require_relative 'player'
require_relative 'display'

class Game
  attr_accessor :turn, :player, :hint
  attr_reader :display
  
  COLORS = Colors.new.keys

  def self.generate_code
    code = []
    colors = COLORS
    code = 4.times.map { colors.sample }
  end

  def initialize
    @turn = 0
    @code = Game.generate_code
    @hint = Hint.new
    @player = Player.new
    @display = Display.new(COLORS)
  end

  def choose_role
    player_role = ""

    until valid_role?(player_role) do
      player_role = display.get_role
    end

    player.breaker = player_role == "1"
  end

  def valid_role?(role)
    role == "1" || role == "2"
  end

  def guess
    # until valid_guess(player_guess)
      # Display.get_guess
    # end

    # check_guess
  end

  def check_guess(player_guess)
    exact = check_exact(player_guess)
    all_matches = check_similar(player_guess)
    similar = all_matches - exact
    hint.exact = exact
    hint.similar = similar
  end

  def check_exact(player_guess)
    matches = 0

    player_guess.each_with_index do |num, i|
      matches += 1 if num == code[i][:val]
    end

    matches
  end

  def check_similar(player_guess)
    matches = 0
    code_copy = code.map { |ele| ele[:val] }

    player_guess.each do |num|
      if code_copy.include?(num)
        code_copy.delete_at(code_copy.index(num))
        matches += 1
      end
    end

    matches
  end

  def valid_guess?(guess)
    return false unless guess.length == 4
    guess.all? { |number| number.between?(1,6) }
  end

  def win?
    hint.exact == 4
  end

  def play_again?(answer)
    if answer == "y" || answer == "Y"
      play
    else
      system("clear")
    end
  end

  def play
    # Display.instructions(COLORS)
    # choose_role
    # until win? 
      # Display.turn
      # guess
  end
end