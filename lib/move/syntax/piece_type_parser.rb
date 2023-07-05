require './lib/standard/chess_piece'
require './lib/standard/chess_board'


class PieceTypeParser

  def parse(move)
    return ChessPiece::PA if ChessBoard::FILES.include? move[0]
    return move[0]
  end

end # PieceTypeParser
