require './lib/standards/piece'

class Move
  # All the possible starting squares
  attr_accessor :starts

  # The destination square
  attr_accessor :target

  # Type and color of the chess piece being play
  attr_accessor :piece, :color
  
  # The starting file or rank of the moving piece
  # These are not always required
  attr_accessor :start_f, :start_r

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
    return nil if to_hash.has_value?(nil) || block_given? == false
    yield to_hash(true)
  end

  private

  # Return a hash of the attributes, all except @starts.
  def to_hash(include_start = false)
    if @piece == Piece::PA && @capture
      { target: @target, piece: @piece, color: @color,
        capture: @capture, start_f: @start_f }
    else
      if include_start
        { target: @target, piece: @piece, color: @color, capture: @capture,
          start_f: @start_f, start_r: @start_r }
      else
        { target: @target, piece: @piece, color: @color, capture: @capture }
      end
    end
  end
end
