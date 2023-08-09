require './lib/board/board_specs'
require './lib/move/move'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


module TestMoves
  module Pawn
    include BoardSpecs
    include PieceSpecs

    def white_singles
      (3..8).to_a.map do |rank|
        files.map do |file|
          move = Move.new(file + rank.to_s, white)
          move.target = { file: file, rank: rank }
          move.piece = ChessPiece.new(pawn, white)
          { move: move, exp_start: { file: file, rank: rank - 1 } }
        end
      end.flatten
    end

    def black_singles
      
    end
  end
end
