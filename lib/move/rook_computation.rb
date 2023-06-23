require './lib/board/board'

module RookComputation

  MOVE = ->(data) do
    return [{ f: data[:start_f], r: data[:target][:r] }] if data[:start_f]
    return [{ f: data[:target][:f], r: data[:start_r] }] if data[:start_r]
    return Helper.all_starts(data[:target][:f], data[:target][:r])
  end

  private

  module Helper 
    class << self
      # Return an array of all squares from which a rook can move to the square
      # of the given file and rank.
      def all_starts(file, rank)
        file_line = Board.get_line(file)
        rank_line = Board.get_line(rank)
        starts = file_line.concat(rank_line)
        starts.delete({ f: file, r: rank })
        starts
      end
    end
  end

end
