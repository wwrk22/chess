require_relative './chess_piece'
require_relative './piece/piece_specs'


class Bishop < ChessPiece
  include PieceSpecs

  UNICODE_WH = "\u2657"
  UNICODE_BL = "\u265D"
  private_constant :UNICODE_WH, :UNICODE_BL

  ##
  # Create a new bishop with its color. Raise error for unknown color.
  def initialize(color)
    super(color)
  end

  ##
  # Return the unicode string "\u2657" or "\u265D" that visually represents a
  # white or black bishop respectively.
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
