require_relative './chess_piece'


class King < ChessPiece
  UNICODE_WH = "\u2654"
  UNICODE_BL = "\u265A"
  private_constant :UNICODE_WH, :UNICODE_BL
end
