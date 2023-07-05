require './lib/standard/chess_piece'
require './lib/standard/chess_board'


module Move

module Syntax

class PieceTypeParser

  def parse(move)
    return ChessPiece::PA if ChessBoard::FILES.include? move[0]
    return move[0]
  end

end # PieceTypeParser

end # Syntax

end # Move
