require './lib/board/board_specs'
require './lib/move/move'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


module TestMoves
  module Pawn
    include BoardSpecs
    include PieceSpecs

    def white_singles
      moves((3..8).to_a, white, -1)
    end

    def black_singles 
      moves((6..1).to_a, black, 1)
    end

    def white_doubles
      moves([4], white, -2)
    end

    def black_doubles
      moves([5], black, 2)
    end

    def moves(ranks, color, step)
      ranks.map do |rank|
        files.map do |file|
          move = Move.new(file + rank.to_s, color)
          move.target = { file: file, rank: rank }
          move.piece = ChessPiece.new(pawn, color)
          { move: move, exp_start: { file: file, rank: rank + step } }
        end
      end.flatten
    end
  end
end
