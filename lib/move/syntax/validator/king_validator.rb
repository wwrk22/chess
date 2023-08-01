require_relative '../move/king_moves'
require './lib/error/color_unknown_error'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


class KingValidator
  include PieceSpecs
  
  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, color)
    raise ColorUnknownError.new(color) if valid_color?(color) == false
    move_str =~ KingMoves::MOVE || move_str =~ KingMoves::CASTLE ?
      ChessPiece.new(king, color) : nil
  end

end
