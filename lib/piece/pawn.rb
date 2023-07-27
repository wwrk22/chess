require_relative './chess_piece'
require_relative './piece_specs'


class Pawn < ChessPiece
  include PieceSpecs

  UNICODE_WH = "\u2659"
  UNICODE_BL = "\u265F"
  private_constant :UNICODE_WH, :UNICODE_BL

  ##
  # Create a new pawn with its color. Raise error for unknown color.
  def initialize(color)
    super(pawn, color)
  end

  ##
  # Return the unicode string "\u2659" or "\u265F" that visually represents a
  # white or black pawn respectively.
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
