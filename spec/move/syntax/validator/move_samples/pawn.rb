require './lib/board/board_specs'


module MoveSamples
  module Pawn
    include BoardSpecs

    def legal_wh_pawn_moves
      a = pawn_moves((3..8).to_a)
      a + add_capture(a)
    end

    def legal_bl_pawn_moves
      a = pawn_moves((1..6).to_a)
      a + add_capture(a)
    end

    def pawn_moves(ranks)
      files.map do |file|
        ranks.reduce([]) do |moves, rank|
          moves << file + rank.to_s
          moves << file + rank.to_s + '+'
          moves << file + rank.to_s + '#'
        end
      end.flatten
    end

    def add_capture(moves, add_same_file = false)
      files.map do |file|
        moves.reduce([]) do |moves, move|
          capture = file + 'x' + move

          if add_same_file
            moves << capture if move.include? file
          else
            moves << capture if not move.include? file
          end

          moves
        end
      end.flatten
    end

    def illegal_wh_pawn_moves
      a = pawn_moves([1, 2])
      b = add_capture(a)
      c = add_capture(a, true)
      d = pawn_moves((3..8).to_a)
      e = add_capture(d, true)
      a + b + c + e
    end

    def illegal_bl_pawn_moves
      a = pawn_moves([7, 8])
      b = add_capture(a)
      c = add_capture(a, true)
      d = pawn_moves((1..6).to_a)
      e = add_capture(d, true)
      a + b + c + e
    end
  end
end
