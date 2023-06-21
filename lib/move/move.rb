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
  # to output an array of squares. If any of the necessary information is
  # missing, thn return false. Otherwise, proceed to call the block, then
  # return true.
  def compute_starts
    return false if to_hash.has_value?(nil) || block_given? == false
    @starts = yield(to_hash)
    return true
  end

  private

  # Return a hash of the attributes, all except @starts.
  def to_hash
    { target: @target, piece: @piece, color: @color, capture: @capture }
  end
end
