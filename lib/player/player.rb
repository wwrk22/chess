require './lib/error/color_unknown_error'
require './lib/move/syntax/validator/validator'
require './lib/piece/piece_specs'
require './lib/move/move'
require './lib/move/pawn_move'


class Player
  include PieceSpecs

  attr_reader :name, :color
  attr_accessor :last_move # Store the last move that was made.

  def initialize(name, color)
    raise ColorUnknownError.new if not valid_color? color

    @name = name
    @color = color
    @validator = Validator.new
  end

  def prompt_move
    move_str = gets.chomp
    piece = @validator.validate(move_str, @color)

    return PawnMove.new(move_str, @color) if piece.type == pawn
    return Move.new(move_str, @color)
  end
end
