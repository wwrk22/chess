require './lib/standard/chess_piece'
require './lib/standard/chess_board'

module Move

module Syntax

class Validator

  def validate(move)
  end


  class PieceTypeParser

    def parse(move)
      return ChessPiece::PA if ChessBoard::FILES.start_with? move[:move][0]
      return move[:move][0]
    end

  end # PieceTypeParser

end # Validator
    
end # Syntax

end # Move
