require_relative './standards/pieces'
require_relative './move/syntax_validator'

class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
    @syn_vtor = SyntaxValidator.new
  end

  def prompt_move
    input = gets.chomp
    return { move: input, color: @color } if @syn_vtor.validate(input)
  end
end
