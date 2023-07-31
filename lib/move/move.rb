class Move

  def initialize(str, color)
    @str = str
    @color = color
  end

  # The raw string format of the move given by player.
  attr_accessor :str

  # The kind of chess piece being moved.
  attr_accessor :piece

  # The file or rank the moving piece is at.
  attr_accessor :start_coordinate

  # The possible starting squares of the moving piece used only when the moving
  # piece is a pawn or a knight.
  attr_accessor :start

  # The target square that the @piece is moving to or capturing.
  attr_accessor :target

  # Indicate whether or not the move is a capture.
  # Format: Boolean
  attr_accessor :capture
end
