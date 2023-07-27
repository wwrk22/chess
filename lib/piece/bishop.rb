require_relative './chess_piece'


class Bishop < ChessPiece
  UNICODE_WH = "\u2657"
  UNICODE_BL = "\u265D"
  private_constant :UNICODE_WH, :UNICODE_BL
end
