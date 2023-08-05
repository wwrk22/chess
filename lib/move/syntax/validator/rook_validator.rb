require_relative '../move/rook_moves'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


class RookValidator
  include PieceSpecs

  # Return the ChessPiece object representing the moving rook if move has valid
  # syntax. Otherwise, return nil. Raise ColorUnknownError if color is unknown.
  def validate(move_str, color)
    ChessPiece.new(rook, color) if move_str =~ RookMoves::MOVE
  end
end
