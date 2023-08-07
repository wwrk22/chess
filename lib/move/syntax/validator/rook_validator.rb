require_relative '../pattern/rook'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


class RookValidator
  include PieceSpecs
  include MoveSyntax::Rook

  # Return the ChessPiece object representing the moving rook if move has valid
  # syntax. Otherwise, return nil.
  def validate(move_str, color)
    ChessPiece.new(rook, color) if move_str =~ rook_move_syntax
  end
end
