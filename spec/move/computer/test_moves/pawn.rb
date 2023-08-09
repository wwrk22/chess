require './lib/board/board_specs'
require './lib/move/move'
require './lib/move/pawn_move'
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

    def captures(rank, color, step)
      files.map do |file|
        move = Move.new(file + rank.to_s, color, true)
        move.target = { file: file, rank: rank }
        move.piece = ChessPiece.new(pawn, color)
        start_file = (file == 'h') ? 'g' : (file.ord + 1).chr
        move.start_coordinate = start_file
        move.str = move.start_coordinate + 'x' + file + rank.to_s
        { move: move, exp_start: { file: start_file, rank: rank + step } }
      end
    end

    def en_passants(files, color)
      step, rank = (color == white) ? [-1, 6] : [1, 3]

      files.map do |file|
        move = PawnMove.new((file.ord + 1).chr + 'x'+ file + '6', color, true)
        move.ep = true
        move.ep_sq = { file: file, rank: rank + step }
        move.target = { file: file, rank: rank }
        move.piece = ChessPiece.new(pawn, color)
        move.start_coordinate = (file.ord + 1).chr
        { move: move, exp_start: { file: move.start_coordinate, rank: rank + step } }
      end
    end
  end
end
