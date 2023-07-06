class Move
  # The type and color of the piece making the move.
  # Interpreted by MoveInterpreter.
  attr_accessor :moving_piece

  # The target square that the @moving_piece is moving to or capturing.
  # Interpreted by MoveInterpreter.
  attr_accessor :target

  # Indicate whether or not the move is a capture.
  # Format: Boolean
  # Interpreted by MoveInterpreter.
  attr_accessor :capture

  # The possible starting squares of the moving piece used only when the moving
  # piece is a pawn or a knight.
  # Computed by a move computer.
  attr_accessor :starts

  # The directions from @target that can be followed to check for possible
  # starting squares of @moving_piece. This is used by all piece types except
  # for pawn and knight.
  # Computed by a move computer.
  attr_accessor :directions
end
