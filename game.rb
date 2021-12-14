require_relative 'colors'
require_relative 'hint'
require_relative 'player'
require_relative 'computer'
require_relative 'display'
require "colorize"

class Game
  attr_accessor :turn, :player, :hint
  attr_reader :display, :code, :computer
  
  COLORS = Colors.new.keys

  def self.generate_colors
    code = []
    colors = COLORS
    code = 4.times.map { colors.sample }
  end

  def initialize
    @turn = 0
    @code = Game.generate_colors
    @hint = Hint.new
    @player = Player.new
    @computer = Computer.new
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

  def generate_keys(input_code)
    new_codes = []

    input_code.each do |new_code|
      new_codes << COLORS.find { |color| color[:val] == new_code }
    end

    new_codes
  end

  def create_code
    player_code = []

    until valid_code?(player_code)
      player_code = display.create_code.map(&:to_i)

      unless valid_code?(player_code)
        puts "Your code must be 4 digits, using numbers 1-6.".colorize(:red)
      end
    end

    @code = generate_keys(player_code)
  end

  def guess
    @turn += 1

    if player.breaker
      player_guess = []

      until valid_code?(player_guess)
        player_guess = display.get_guess(turn)
        exit if player_guess.length == 1 && player_guess[0] == 'q'

        player_guess.map!(&:to_i)

        unless valid_code?(player_guess)
          puts "Your code must be 4 digits, using numbers 1-6.".colorize(:red)
        end
      end
    else
      player_guess = computer.generate_guess
    end
    
    check_guess(player_guess)

    guess_codes = generate_keys(player_guess)
  end

  def valid_code?(guess)
    return false unless guess.length == 4
    guess.all? { |number| number.between?(1,6) }
  end

  def code_instances(num, guess_idx)
    indices = []

    code.each_with_index do |ele, i|
      unless guess_idx == i
        indices << i if ele[:val] == num
      end
    end
    
    indices
  end

  def check_guess(player_guess)
    hint.exact, = 0
    hint.similar = 0
    updated_guess = check_exact(player_guess)
    check_similar(updated_guess)
    player_guess
  end

  def check_exact(player_guess)
    guess_copy = player_guess.clone

    guess_copy.each_with_index do |num, i|
      if num == code[i][:val]
        hint.exact += 1
        guess_copy[i] = nil
      end
    end

    guess_copy
  end

  def check_similar(player_guess)
    codes = []
    code.each_with_index do |color, i| 
      if player_guess[i] == nil
        codes << nil
      else
        codes << color[:val]
      end
    end

    player_guess.each_with_index do |num, i|
      unless num == nil
        if codes.include?(num)
          hint.similar += 1
          code_index = codes.index(num)
          codes[code_index] = nil
        end
      end
    end

    player_guess
  end

  def win?
    hint.exact == 4
  end

  def reset
    @turn = 0
    hint.exact = 0
    @code = Game.generate_colors
  end

  def play_again?(answer)
    if answer == "y" || answer == "Y"
      reset
      play
    else
      system("clear")
    end
  end

  def play
    display.instructions

    choose_role

    if player.breaker
      until win?
        player_guess = guess
        display.display_results(player_guess, hint)
      end

      display.winner(turn)
    else
      create_code
      until win?
        computer_guess = guess
        display.computer_display(turn, computer_guess, hint)
      end

      display.computer_win(turn)
    end

    answer = display.another_round?
    play_again?(answer)
  end
end