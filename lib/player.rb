require_relative './standards/pieces'

class Player

  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  def prompt_move
  end
end
