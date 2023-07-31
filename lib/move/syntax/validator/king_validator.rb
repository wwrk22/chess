require_relative '../move/king_moves'
require './lib/error/color_unknown_error'
require './lib/piece/piece_specs'


class KingValidator
  include PieceSpecs
  
  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    if player_color != white && player_color != black
      raise ColorUnknownError.new(player_color)
    end

    move_str =~ KingMoves::MOVE || move_str =~ KingMoves::CASTLE ?
      king : nil
  end

end
