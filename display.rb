require 'colorize'
require 'nokogiri'

class Display
  attr_reader :colors

  def initialize(colors)
    @colors = colors
  end

  def instructions
    system("clear")
    exact_sym = Nokogiri::HTML.parse("&#9679; ").text
    num_sym = Nokogiri::HTML.parse("&#9675; ").text

    puts "How to play: ".colorize(:black).colorize(:background => :white)
    puts
    puts "You choose to be the code maker or the breaker."
    puts
    puts "There are 6 number/color combinations: ".colorize(:black).colorize(:background => :white)
    display_guess(colors)
    puts
    puts
    puts "The code maker will create a 'master code' using 4 of these, like:"
    display_guess([colors[1], colors[5], colors[0], colors[5]])
    puts
    puts
    puts "Hints: ".colorize(:black).colorize(:background => :white)
    puts "After each guess, there will be hints to help you decipher the code."
    puts "#{exact_sym}Each of these hints indicate that you have a correct number/color in correct location."
    puts
    puts "#{num_sym}Each of these hints indicate that you have a correct number/color, but in wrong location."
    puts
    puts "Hint Example: ".colorize(:black).colorize(:background => :white)
    display_guess([colors[1], colors[5], colors[5], colors[3]])
    puts " Hints: #{exact_sym}#{exact_sym}#{num_sym}"
    puts
    puts "The guess had 2 correct numbers/colors in the correct location and 1 correct number/color in the wrong location."
  end

  def display_guess(colors)
    colors.each do |color|
      print "  #{color[:val]}  ".colorize(:background => color[:color])
    end
  end

  def display_hint(hint)
    exact_sym = Nokogiri::HTML.parse "&#9679; "
    num_sym = Nokogiri::HTML.parse "&#9675; "
    hint.exact.times { print exact_sym.text }
    hint.similar.times { print num_sym.text }
  end

  def get_role
    puts "It's time to start the game.".colorize(:black).colorize(:background => :white)
    puts "Would you like to Break or Make the code?"
    puts "Enter '1' to Break the code."
    puts "Enter '2' to Make the code"

    gets.chomp
  end

  def create_code
    puts "Enter a 4-digit code, using numbers 1-6. The computer will attempt to break it."
    gets.chomp.split("")
  end

  def get_guess(turn)
    print "Guess ##{turn}: "
    puts "Using numbers 1-6, enter 4-digits to attempt to break the code or enter 'q' to quit the game."
    gets.chomp.split("")
  end

  def display_results(guess, hint)
    display_guess(guess)
    print "   "
    unless hint.exact == 4
      display_hint(hint)
    end
    puts
  end

  def winner(turn)
    puts "You cracked the code in just #{turn} turns!"
  end

  def another_round?
    puts "Would you like the play the game again? If so enter 'y', and if not enter any other key."
    gets.chomp
  end
end