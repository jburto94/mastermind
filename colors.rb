class Colors
  attr_reader :keys

  COLORED_KEYS = [
    {
      color: :red,
      val: 1
    },
    {
      color: :cyan,
      val: 2
    },
    {
      color: :light_red,
      val: 3
    },
    {
      color: :green,
      val: 4
    },
    {
      color: :blue,
      val: 5
    },
    {
      color: :magenta,
      val: 6
    }
  ]

  def initialize
    @keys = COLORED_KEYS
  end
end