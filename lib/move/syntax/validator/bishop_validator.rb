require_relative '../move/bishop_moves'
require './lib/error/color_unknown_error'
require './lib/piece/piece_specs'
require './lib/piece/chess_piece'


class BishopValidator
  include PieceSpecs

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, color)
    raise ColorUnknownError.new(color) if not valid_color?(color)
    ChessPiece.new(bishop, color) if (move_str =~ BishopMoves::MOVE)
  end
end
