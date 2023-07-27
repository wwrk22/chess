require_relative './chess_piece'
require_relative './piece_specs'


class Pawn < ChessPiece
  include PieceSpecs

  UNICODE_WH = "\u2659"
  UNICODE_BL = "\u265F"
  private_constant :UNICODE_WH, :UNICODE_BL

  attr_reader :color

  def initialize(color)
    @color = color
  end

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
