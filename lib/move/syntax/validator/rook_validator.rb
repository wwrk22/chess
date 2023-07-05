require_relative '../move/rook_moves'
require './lib/standard/chess_piece'
require './lib/error/color_unknown_error'


class RookValidator

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move)
    if move[:color] != ChessPiece::WH && move[:color] != ChessPiece::BL
      raise ColorUnknownError.new(move[:color])
    end

    return validate_capture(move) if move[:move].include? 'x'
    return move if move[:move] =~ RookMoves::MOVE
  end

  private

  def validate_capture(move)
    RookMoves::CAPTURES.each do |capture|
      return move if move[:move] =~ capture
    end

    nil
  end

end
