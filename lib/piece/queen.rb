require_relative './chess_piece'
require_relative './piece_specs'


class Queen
 include PieceSpecs

  UNICODE_WH = "\u2655"
  UNICODE_BL = "\u265B"
  private_constant :UNICODE_WH, :UNICODE_BL

  ##
  # Create a new queen with its color. Raise error for unknown color.
  def initialize(color)
    super(queen, color)
  end

  ##
  # Return the unicode string "\u2657" or "\u265D" that visually represents a
  # white or black queen respectively.
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
