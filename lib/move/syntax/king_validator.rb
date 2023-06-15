require_relative './king_moves'
require './lib/errors/color_unknown_error'
require './lib/standards/piece'

module Move
module Syntax
class KingValidator
  
  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move)
    if move[:color] != Piece::WH && move[:color] != Piece::BL
      raise ColorUnknownError.new(move[:color])
    end

    move if move[:move] =~ KingMoves::MOVE || move[:move] =~ KingMoves::CASTLE
  end

end
end
end
