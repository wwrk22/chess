require_relative './chess_piece'


class Knight < ChessPiece
  UNICODE_WH = "\u2658"
  UNICODE_BL = "\u265E"
  private_constant :UNICODE_WH, :UNICODE_BL
end
