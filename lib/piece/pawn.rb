require_relative './chess_piece'


class Pawn < ChessPiece
  UNICODE_WH = "\u2659"
  UNICODE_BL = "\u265F"
  private_constant :UNICODE_WH, :UNICODE_BL

  class << self
    def unicode_wh
      UNICODE_WH
    end

    def unicode_bl
      UNICODE_BL
    end
  end
end
