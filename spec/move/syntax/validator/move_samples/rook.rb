require './lib/board/board_specs'
require './lib/piece/piece_specs'


module MoveSamples
  module Rook
    include BoardSpecs
    include PieceSpecs

    def rook_moves
      a = files.map do |file|
        ranks.map do |rank|
          rook + file + rank.to_s
        end
      end.flatten

      b = add_start_file(a)
      c = add_start_rank(a)

      a + b + c
    end

    def rook_captures
      a = files.map do |file|
        ranks.map do |rank|
          rook + 'x' + file + rank.to_s
        end
      end.flatten

      b = add_start_file(a)
      c = add_start_rank(a)
    end

    def add_start_file(moves)
      files.map do |file|
        moves.map do |move|
          move.sub('R', 'R' + file)
        end
      end.flatten
    end

    def add_start_rank(moves)
      ranks.map do |rank|
        moves.map do |move|
          move.sub('R', 'R' + rank.to_s)
        end
      end.flatten
    end
  end
end
