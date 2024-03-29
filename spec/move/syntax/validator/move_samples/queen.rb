require './lib/board/board_specs'
require './lib/piece/piece_specs'


module TestMoves
  module Queen
    include BoardSpecs
    include PieceSpecs

    def queen_basic_moves
      files.map do |file|
        ranks.reduce([]) do |moves, rank|
          moves << queen + file + rank.to_s
          moves << queen + file + rank.to_s + '+'
          moves << queen + file + rank.to_s + '#'
          moves << queen + 'x' + file + rank.to_s
          moves << queen + 'x' + file + rank.to_s + '+'
          moves << queen + 'x' + file + rank.to_s + '#'
        end
      end.flatten
    end

    def legal_queen_moves
      moves_with_start_coord =  queen_basic_moves.map do |move|
        (files + ranks).reduce([]) do |moves, coord|
          coord = coord.to_s if valid_rank? coord
          moves << move.sub(queen, queen + coord)
        end
      end.flatten

      queen_basic_moves + moves_with_start_coord
    end
  end
end
