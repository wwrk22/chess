class Move
  # All the possible starting squares
  attr_accessor :starts

  # The destination square
  attr_accessor :target

  # Type and color of the chess piece being play
  attr_accessor :piece, :color

  # Tell whether or not the move is a capture
  attr_accessor :capture

  def initialize
    @capture = false
  end
end
