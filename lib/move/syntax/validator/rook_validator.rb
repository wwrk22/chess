require_relative '../move/rook_moves'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


class RookValidator
  include PieceSpecs

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    if player_color != white && player_color != black
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
