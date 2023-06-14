require './lib/standards/piece'

class ColorUnknownError < StandardError
  def initialize(color)
    msg = "Color must be #{Piece::WH} or #{Piece::BL}. #{color} is unknown."
    super(msg)
  end
end
