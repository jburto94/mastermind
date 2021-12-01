require_relative = 'colors'
require 'nokogiri'

class Hint
  attr_accessor :exact, :similar

  def initialize()
    @exact= 0
    @similar = 0
  end

  def update_hint(exact_guesses, similar_guesses)
    @exact = exact_guesses
    @similar = similar_guesses
  end
end