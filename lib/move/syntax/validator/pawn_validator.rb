require_relative '../pattern/pawn'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


class PawnValidator
  include PieceSpecs
  include MoveSyntax::Pawn

  # Return the ChessPiece object representing the moving pawn if move has valid
  # syntax. Otherwise, return nil. Raise ColorUnknownError if color is unknown.
  def validate(move_str, color)
    raise ColorUnknownError.new(color) if not valid_color? color

    pattern = (color == white) ?
      wh_pawn_move_syntax : bl_pawn_move_syntax

    match = move_str =~ pattern
    ChessPiece.new(pawn, color) if match
  end
end
