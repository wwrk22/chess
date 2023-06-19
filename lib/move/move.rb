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

  # Use all of the data in this Move except for @starts to compute all possible
  # starting squares. A block that performs the actual computation is required
  # to output an array of squares.
  def compute_starts
    data = { target: @target, piece: @piece, color: @color, capture: @capture }
    yield(data)
  end
end
