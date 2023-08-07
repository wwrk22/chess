require_relative '../pattern/king'
require './lib/error/color_unknown_error'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


class KingValidator
  include PieceSpecs
  include MoveSyntax::King
  
  # Return the move if move has valid syntax. Otherwise, return nil.
  def validate(move_str, color)
    regex_match = move_str =~ /#{king_move_syntax}|#{king_castle_syntax}/
    ChessPiece.new(king, color) if regex_match
  end

end
