require_relative '../move/queen_moves'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


class QueenValidator
  include PieceSpecs

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    if player_color != white && player_color != black
      raise ColorUnknownError.new(player_color)
    end

    (move_str =~ QueenMoves::MOVE) ? queen : nil
  end
end
