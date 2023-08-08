require './lib/board/board_specs'
require './lib/piece/piece_specs'


module MoveSamples
  module Knight
    include BoardSpecs
    include PieceSpecs

    def coord_diff_check
      ->(coord_diff, is_valid_range) do
        if is_valid_range
          coord_diff == 1 || coord_diff == 2
        else
          coord_diff != 1 && coord_diff != 2
        end
      end
    end

    def legal_knight_moves
      a = basic_moves
      b = knight_moves_with_file(a, true, &coord_diff_check)
      c = knight_moves_with_rank(a, true, &coord_diff_check)
      a + b + c
    end # legal_knight_moves

    def illegal_knight_moves
      a = knight_moves_with_file(basic_moves, false, &coord_diff_check)
      b = knight_moves_with_rank(basic_moves, false, &coord_diff_check)
      a + b
    end

    def basic_moves
      files.map do |file|
        ranks.reduce([]) do |moves, rank|
          moves << knight + file + rank.to_s
          moves << knight + file + rank.to_s + '+'
          moves << knight + file + rank.to_s + '#'
        end
      end.flatten
    end

    def knight_moves_with_file(moves, is_valid_range, &coord_diff_check)
      moves.map do |move|
        files.reduce([]) do |moves, file|
          file_diff = (move[1].ord - file.ord).abs

          if coord_diff_check.call(file_diff, is_valid_range)
            moves << move.sub(knight, knight + file)
          end

          moves
        end
      end.flatten
    end

    def knight_moves_with_rank(moves, is_valid_range, &coord_diff_check)
      moves.map do |move|
        ranks.reduce([]) do |moves, rank|
          rank_diff = (move[2].to_i - rank).abs

          if coord_diff_check.call(rank_diff, is_valid_range)
            moves << move.sub(knight, knight + rank.to_s)
          end

          moves
        end
      end.flatten
    end
  end
end
