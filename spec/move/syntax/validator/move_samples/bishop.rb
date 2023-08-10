require './lib/board/board_specs'


module TestMoves
  module Bishop
    include BoardSpecs
    include PieceSpecs
    
    def legal_bishop_moves
      a = basic_bishop_moves
      b = bishop_moves_with_start_file(a) 
      c = bishop_moves_with_start_rank(a)
      a + b + c
    end

    def illegal_bishop_moves
      basic_bishop_moves.map do |move|
        illegal_moves_a = files.reduce([]) do |filtered, file|
          filtered << move.sub(bishop, bishop + file) if move.include? file
          filtered
        end

        illegal_moves_b = ranks.reduce([]) do |filtered, rank|
          filtered << move.sub(bishop, bishop + rank.to_s) if move.include? rank.to_s
          filtered
        end

        illegal_moves_a + illegal_moves_b
      end.flatten
    end

    def basic_bishop_moves
      files.map do |file|
        ranks.reduce([]) do |moves, rank|
          moves << bishop + file + rank.to_s
          moves << bishop + file + rank.to_s + '+'
          moves << bishop + file + rank.to_s + '#'
        end
      end.flatten
    end

    def bishop_moves_with_start_file(moves)
      moves.map do |move|
        files.reduce([]) do |filtered, file|
          filtered << move.sub(bishop, bishop + file) if not move.include? file
          filtered
        end
      end.flatten
    end
    
    def bishop_moves_with_start_rank(moves)
      moves.map do |move|
        ranks.reduce([]) do |filtered, rank|
          filtered << move.sub(bishop, bishop + rank.to_s) if not move.include? rank.to_s
          filtered
        end
      end.flatten
    end
  end
end
