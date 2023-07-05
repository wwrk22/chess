require_relative '../move/queen_moves'
require './lib/standard/chess_piece'
require './lib/error/color_unknown_error'


class QueenValidator

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move)
    if move[:color] != ChessPiece::WH && move[:color] != ChessPiece::BL
      raise ColorUnknownError.new(move[:color])
    end

    move if move[:move] =~ QueenMoves::MOVE
  end

end
