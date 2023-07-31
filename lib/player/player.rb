require './lib/move/syntax/validator/validator'


class Player
  attr_reader :name, :color
  attr_accessor :last_move # Store the last move that was made.

  def initialize(name, color)
    @name = name
    @color = color
    @validator = Validator.new
  end

  def prompt_move
    input = gets.chomp
    validated_input = @validator.validate(input, @color)
    validated_input.nil? ? nil : Move.new(validated_input, @color)
  end
end
