class Move
  # The type and color of the piece making the move.
  attr_accessor :moving_piece

  # The target square that the @moving_piece is moving to or capturing.
  attr_accessor :target

  # Indicate whether or not the move is a capture.
  # Format: Boolean
  attr_accessor :capture

  # The possible starting squares of the moving piece used only when the moving
  # piece is a pawn or a knight.
  attr_accessor :starts

  # The directions from @target that can be followed to check for possible
  # starting squares of @moving_piece. This is used by all piece types except
  # for pawn and knight.
  attr_accessor :directions
end
