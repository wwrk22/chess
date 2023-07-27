require_relative './chess_piece'


class Rook < ChessPiece
  UNICODE_WH = "\u2656"
  UNICODE_BL = "\u265C"
  private_constant :UNICODE_WH, :UNICODE_BL
end
