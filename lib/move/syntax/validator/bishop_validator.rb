require_relative '../pattern/bishop'
require './lib/error/color_unknown_error'
require './lib/piece/piece_specs'
require './lib/piece/chess_piece'


class BishopValidator
  include PieceSpecs
  include MoveSyntax::Bishop

  # Return the move if move has valid syntax. Otherwise, return nil.
  def validate(move_str, color)
    ChessPiece.new(bishop, color) if move_str =~ bishop_move_syntax
  end
end
