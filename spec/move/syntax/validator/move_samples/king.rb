require './lib/board/board_specs'
require './lib/piece/piece_specs'
require './lib/move/syntax/pattern/king'


module MoveSamples
  module King
    include BoardSpecs
    include PieceSpecs

    def basic_moves
      files.map do |file|
        ranks.reduce([]) do |moves, rank|
          moves << king + file + rank.to_s
          moves << king + file + rank.to_s + '+'
          moves << king + file + rank.to_s + '#'
        end
      end.flatten
    end

    def legal_king_moves
      castles = ["0-0", "0-0-0"].reduce([]) do |moves, move|
        moves << move
        moves << move + "+"
        moves << move + "#"
      end

      basic_moves.concat(castles)
    end

    def illegal_king_moves
      a = basic_moves.map do |move|
        files.map do |file|
          move.sub(king, king + file)
        end
      end.flatten

      b = basic_moves.map do |move|
        ranks.map do |rank|
          move.sub(king, king + rank.to_s)
        end
      end.flatten
    end
  end
end
