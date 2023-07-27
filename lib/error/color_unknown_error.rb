require './lib/piece/piece_specs'

class ColorUnknownError < StandardError
  include PieceSpecs

  def initialize(color)
    msg = "Color must be #{white} or #{black}. #{color} is unknown."
    super(msg)
  end
end
