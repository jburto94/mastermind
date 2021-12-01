require_relative = 'colors'
require 'nokogiri'

class Hint
  attr_accessor :correct, :similar

  def initialize()
    @exact= 0
    @similar = 0
  end

  def update_hint(exact_guesses, similar_guesses)
    @exact = exact_guesses
    @similar = similar_guesses
  end

  def display_hint
    exact_sym = Nokogiri::HTML.parse "&#9679; "
    num_sym = Nokogiri::HTML.parse "&#9675; "
    exact.times { print exact_sym.text }
    similar.times { print num_sym.text }
  end
end