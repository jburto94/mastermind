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
    color_display(colors)
    puts
    puts
    puts "The code maker will create a 'master code' using 4 of these, like:"
    color_display([colors[1], colors[5], colors[0], colors[5]])
    puts
    puts
    puts "Hints: ".colorize(:black).colorize(:background => :white)
    puts "After each guess, there will be hints to help you decipher the code."
    puts "#{exact_sym}Each of these hints indicate that you have a correct number/color in correct location."
    puts
    puts "#{num_sym}Each of these hints indicate that you have a correct number/color, but in wrong location."
    puts
    puts "Hint Example: ".colorize(:black).colorize(:background => :white)
    color_display([colors[1], colors[5], colors[5], colors[3]])
    puts " Hints: #{exact_sym}#{exact_sym}#{num_sym}"
    puts
    puts "The guess had 2 correct numbers/colors in the correct location and 1 correct number/color in the wrong location."
  end

  def color_display(colors)
    colors.each do |color|
      print " #{color[:val]} ".colorize(:background => color[:color])
    end
  end

  def get_role
    puts "It's time to start the game.".colorize(:black).colorize(:background => :white)
    puts "Would you like to Break or Make the code?"
    puts "Enter '1' to Break the code."
    puts "Enter '2' to Make the code"

    gets.chomp
  end
end