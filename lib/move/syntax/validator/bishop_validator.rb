require_relative '../move/bishop_moves'
require './lib/error/color_unknown_error'


class BishopValidator

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move)
    if move[:color] != ChessPiece::WH && move[:color] != ChessPiece::BL
      raise ColorUnknownError.new(move[:color])
    end

    move if move[:move] =~ BishopMoves::MOVE
  end
end
