require_relative '../move/bishop_moves'
require './lib/error/color_unknown_error'
require './lib/piece/piece_specs'
require './lib/piece/chess_piece'


class BishopValidator
  include PieceSpecs

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, color)
    raise ColorUnknownError.new(color) if valid_color?(color) == false
    (move_str =~ BishopMoves::MOVE) ? ChessPiece.new(bishop, color) : nil
  end
end
