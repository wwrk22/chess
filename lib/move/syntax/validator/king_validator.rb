require_relative '../move/king_moves'
require './lib/error/color_unknown_error'
require './lib/standard/chess_piece'


class KingValidator
  
  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    if player_color != ChessPiece::WH && player_color != ChessPiece::BL
      raise ColorUnknownError.new(player_color)
    end

    move_str if move_str =~ KingMoves::MOVE || move_str =~ KingMoves::CASTLE
  end

end
