class Move

  def initialize(str, color, capture = false)
    @str = str
    @color = color
    @capture = capture
  end

  # The raw string format of the move given by player.
  attr_accessor :str

  # The exact chess piece being moved.
  attr_accessor :piece

  # The file or rank the moving piece is at.
  attr_accessor :start_coordinate

  # The exact square from which the moving piece starts. If after a move start
  # computation this value is nil, then it indicates this Move as a whole is
  # illegal.
  attr_accessor :start

  # The target square that the moving piece is moving to or capturing at.
  attr_accessor :target

  # Indicate whether or not the move is a capture.
  attr_accessor :capture
end
