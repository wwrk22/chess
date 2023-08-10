require_relative '../pattern/pawn'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


class PawnValidator
  include PieceSpecs
  include MoveSyntax::Pawn

  # Return the ChessPiece object representing the moving pawn if move has valid
  # syntax. Otherwise, return nil.
  def validate(move_str, color)
    if color == white
      return ChessPiece.new(pawn, color) if move_str =~ wh_pawn_move_syntax
    else
      return ChessPiece.new(pawn, color) if move_str =~ bl_pawn_move_syntax
    end
  end
end
