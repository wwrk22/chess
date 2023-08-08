require_relative '../pattern/knight'
require './lib/error/color_unknown_error'
require './lib/piece/piece_specs'
require './lib/piece/chess_piece'


class KnightValidator
  include PieceSpecs
  include MoveSyntax::Knight

  # Return the move if move has valid syntax. Otherwise, return nil.
  def validate(move_str, color)
    if knight_move_syntax.one? { |pattern| move_str =~ pattern }
      return ChessPiece.new(knight, color)
    end
  end
end
