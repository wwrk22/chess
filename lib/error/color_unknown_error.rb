require './lib/standard/chess_piece'

class ColorUnknownError < StandardError
  def initialize(color)
    white = ChessPiece::WH
    black = ChessPiece::BL
    msg = "Color must be #{white} or #{black}. #{color} is unknown."
    super(msg)
  end
end
