require_relative '../move/bishop_moves'
require './lib/error/color_unknown_error'


class BishopValidator

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    if player_color != ChessPiece::WH && player_color != ChessPiece::BL
      raise ColorUnknownError.new(player_color)
    end

    move_str if move_str =~ BishopMoves::MOVE
  end
end
