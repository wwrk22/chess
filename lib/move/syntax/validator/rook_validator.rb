require_relative '../move/rook_moves'
require './lib/standard/chess_piece'
require './lib/error/color_unknown_error'


class RookValidator

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    if player_color != ChessPiece::WH && player_color != ChessPiece::BL
      raise ColorUnknownError.new(player_color)
    end

    return validate_capture(move_str) if move_str.include? 'x'
    return move_str if move_str =~ RookMoves::MOVE
  end

  private

  def validate_capture(move_str)
    RookMoves::CAPTURES.each do |capture|
      return move_str if move_str =~ capture
    end

    nil
  end

end
