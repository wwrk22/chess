require_relative '../move/knight_moves'
require './lib/error/color_unknown_error'
require './lib/piece/piece_specs'


class KnightValidator
  include PieceSpecs

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    if player_color != white && player_color != black
      raise ColorUnknownError.new(player_color)
    end

    check_syntax(move_str)
  end

  private

  def check_syntax(move_str)
    KnightMoves::MOVES.each do |pattern|
      return move_str if move_str =~ pattern
    end

    nil
  end

end
