require_relative '../pattern/knight'
require './lib/error/color_unknown_error'
require './lib/piece/piece_specs'
require './lib/piece/chess_piece'


class KnightValidator
  include PieceSpecs
  include MoveSyntax::Knight

  # Return the move if move has valid syntax. Otherwise, return nil.
  def validate(move_str, color)
    regex_match = knight_move_syntax.one? { |pattern| move_str =~ pattern }
    ChessPiece.new(knight, color) if regex_match
  end
end
