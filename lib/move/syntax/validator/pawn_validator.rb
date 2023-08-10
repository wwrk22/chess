require_relative '../pattern/pawn'
require './lib/piece/pawn'
require './lib/piece/piece_specs'


class PawnValidator
  include PieceSpecs
  include MoveSyntax::Pawn

  # Return the ChessPiece object representing the moving pawn if move has valid
  # syntax. Otherwise, return nil.
  def validate(move_str, color)
    pattern = (color == white) ? wh_pawn_move_syntax : bl_pawn_move_syntax
    Pawn.new(color) if move_str =~ pattern
  end
end
