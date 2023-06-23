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

  def compute(&computation)
    @starts = computation.call(to_hash)
  end

  private

  def to_hash
    { target: @target, color: @color,
      start_f: @start_f ? @start_f : nil,
      start_r: @start_r ? @start_r : nil }
  end

end
