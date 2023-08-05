require_relative './move'


class PawnMove < Move
  
  # Indicate whether or not the capture is an en passant.
  attr_accessor :ep

  # The square of the opponent's pawn during an en passant.
  attr_accessor :ep_sq
end
