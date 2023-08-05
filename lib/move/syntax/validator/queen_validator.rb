require_relative '../move/queen_moves'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


class QueenValidator
  include PieceSpecs

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, color)
    raise ColorUnknownError.new(color) if valid_color?(color) == false
    ChessPiece.new(queen, color) if move_str =~ QueenMoves::MOVE
  end
end
