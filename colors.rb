class Colors
  attr_reader :keys
  
  def initialize
    @keys = Colors.randomize_keys
  end

  def self.randomize_colors
    [:red, :blue, :green, :yellow, :orange, :purple].shuffle
  end
  
  def self.randomize_keys
    colors = Colors.randomize_colors
    color_keys = []
    (1..6).each do |num|
      color_keys.push({
        color: colors.pop,
        val: num
      })
    end

    color_keys
  end 
end