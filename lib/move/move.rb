class Move

  def initialize(str, color)
    @str = str
    @color = color
  end

  # The raw string format of the move given by player.
  attr_accessor :str

  # The color of the player making the move.
  attr_accessor :color

  # The kind of chess piece being moved.
  attr_accessor :piece

  # The target square that the @piece is moving to or capturing.
  attr_accessor :target

  # Indicate whether or not the move is a capture.
  # Format: Boolean
  attr_accessor :capture

  # The possible starting squares of the moving piece used only when the moving
  # piece is a pawn or a knight.
  attr_accessor :start

  # The directions from @target that can be followed to check for possible
  # starting squares of @piece. This is used by all piece types except
  # for pawn and knight.
  attr_accessor :directions
end
