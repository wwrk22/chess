require_relative './chess_piece'
require_relative './piece_specs'


class Rook < ChessPiece
  include PieceSpecs

  UNICODE_WH = "\u2656"
  UNICODE_BL = "\u265C"
  private_constant :UNICODE_WH, :UNICODE_BL

  ##
  # Create a new rook with its color. Raise error for unknown color.
  def initialize(color)
    super(color)
  end

  ##
  # Return the unicode string "\u2656" or "\u265C" that visually represents a
  # white or black rook respectively.
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
