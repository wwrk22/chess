require_relative './chess_piece'
require_relative './piece/piece_specs'


class Knight < ChessPiece
  include PieceSpecs

  UNICODE_WH = "\u2658"
  UNICODE_BL = "\u265E"
  private_constant :UNICODE_WH, :UNICODE_BL

  ##
  # Create a new knight with its color. Raise error for unknown color.
  def initialize(color)
    super(knight, color)
  end

  ##
  # Return the unicode string "\u2658" or "\u265E" that visually represents a
  # white or black knight respectively.
  def unicode
    return @color == white ? UNICODE_WH : UNICODE_BL
  end

  class << self
    def unicode_wh
      UNICODE_WH
    end

    def unicode_bl
      UNICODE_BL
    end
  end
end
