require_relative './move'


class PawnMove < Move
  
  # Indicate whether or not the capture is an en passant.
  attr_accessor :en_passant

  # The square of the opponent's pawn during an en passant.
  attr_accessor :en_passant_square
end
