require_relative './standard/piece'
require_relative './move/syntax_validator'

# Uses the SyntaxValidator to validate player moves.
class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
    @syn_vtor = SyntaxValidator.new
  end

  # Return a hash of the move and color if the move had valid syntax.
  # Otherwise, return nil.
  def prompt_move
    input = gets.chomp
    return { move: input, color: @color } if @syn_vtor.validate(input)
  end
end
