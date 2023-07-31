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
    move_str = gets.chomp
    validation = @validator.validate(move_str, @color)
    validation.nil? ? nil : Move.new(move_str, @color)
  end
end
