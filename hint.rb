require_relative = 'colors'
require 'nokogiri'

class Hint
  attr_accessor :correct, :correct_num

  def initialize()
    @correct = 0
    @correct_num = 0
  end

  def update_hint(correct_guesses, correct_nums)
    @correct = correct_guesses
    @correct_num = correct_nums
  end

  def display_hint
    correct_sym = Nokogiri::HTML.parse "&#9679; "
    num_sym = Nokogiri::HTML.parse "&#9675; "
    correct.times { print correct_sym.text }
    correct_num.times { print num_sym.text }
  end
end