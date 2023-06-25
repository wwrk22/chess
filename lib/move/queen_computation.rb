require './lib/board/board'

module QueenComputation
  
  MOVE = ->(data) do
    target_f, target_r = [data[:target][:f], data[:target][:r]]
    start_f, start_r = [data[:start_f], data[:start_r]]
    return Helper.starts_for_file(target_f, target_r, start_f) if data[:start_f]
    return Helper.starts_for_rank(target_f, target_r, start_r) if data[:start_r]
    return Helper.all_starts(data)
  end

  private

  module Helper
    class << self
      # The difference in squares of the target and starting file is the same
      # measurement used to determine the ranks of the possible starting
      # squares.
      def starts_for_file(target_f, target_r, start_f)
        diff = (target_f.ord - start_f.ord).abs
        starts = [{ f: start_f, r: target_r },
                  { f: start_f, r: target_r - diff },
                  { f: start_f, r: target_r + diff }]
        starts.delete({ f: target_r, r: target_r })
        starts
      end

      # The difference in squares of the target and starting rank is the same
      # measurement used to determine the files of the possible starting
      # squares.
      def starts_for_rank(target_f, target_r, start_r)
        diff = (target_r - start_r).abs
        starts = [{ f: target_f, r: start_r },
                  { f: (target_f.ord - diff).chr, r: start_r },
                  { f: (target_f.ord + diff).chr, r: start_r }]
        starts.delete({ f: target_f, r: target_r })
        starts
      end

      # Return all starts for the target square.
      def all_starts(data)
        all_starts = non_diagonal_starts(data).concat(diagonal_starts(data))
        all_starts.delete({ f: data[:target][:f], r: data[:target][:r] })
        all_starts
      end

      def non_diagonal_starts(data)
        file_line = Board.get_line(data[:target][:f])
        rank_line = Board.get_line(data[:target][:r])
        file_line.concat(rank_line)
      end

      def diagonal_starts(data)
        diagonal_a = Board.get_diagonal_a(data[:target])
        diagonal_b = Board.get_diagonal_b(data[:target])
        diagonal_a.concat(diagonal_b)
      end
    end
  end # module Helper
end
