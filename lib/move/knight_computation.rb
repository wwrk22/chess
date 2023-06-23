require './lib/standards/board_standards'

module KnightComputation

  MOVE = ->(data) do
    return Helper.starts_for_file(data) if data[:start_f]
    return Helper.starts_for_rank(data) if data[:start_r]
    return Helper.all_starts(data[:target][:f], data[:target][:r])
  end

  private

  module Helper
    class << self
      def all_starts(file, rank, starts = [])
        starts.concat(top_right(file, rank))
        starts.concat(bottom_right(file, rank))
        starts.concat(bottom_left(file, rank))
        starts.concat(top_left(file, rank))
        prune_oob_squares(starts)
      end

      def starts_for_file(data, starts = [])
        file_diff = (data[:target][:f].ord - data[:start_f].ord).abs
        starts.concat(one_file_away(data)) if file_diff == 1
        starts.concat(two_files_away(data)) if file_diff == 2
        prune_oob_squares(starts)
      end

      def starts_for_rank(data, starts = [])
        rank_diff = (data[:target][:r] - data[:start_r]).abs
        starts.concat(one_rank_away(data)) if rank_diff == 1
        starts.concat(two_ranks_away(data)) if rank_diff == 2
        prune_oob_squares(starts)
      end

      private

      def one_file_away(data)
        [{ f: data[:start_f], r: data[:target][:r] + 2 },
         { f: data[:start_f], r: data[:target][:r] - 2 }]
      end

      def two_files_away(data)
        [{ f: data[:start_f], r: data[:target][:r] + 1 },
         { f: data[:start_f], r: data[:target][:r] - 1 }]
      end

      def one_rank_away(data)
        [{ f: (data[:target][:f].ord - 2).chr , r: data[:start_r] },
         { f: (data[:target][:f].ord + 2).chr , r: data[:start_r] }]
      end

      def two_ranks_away(data)
        [{ f: (data[:target][:f].ord - 1).chr, r: data[:start_r] },
         { f: (data[:target][:f].ord + 1).chr, r: data[:start_r] }]
      end

      def top_right(file, rank)
        [{ f: (file.ord + 1).chr, r: rank + 2 },
         { f: (file.ord + 2).chr, r: rank + 1 }]
      end

      def bottom_right(file, rank)
        [{ f: (file.ord + 2).chr, r: rank - 1 },
         { f: (file.ord + 1).chr, r: rank - 2 }]
      end

      def bottom_left(file, rank)
        [{ f: (file.ord - 1).chr, r: rank - 2 },
         { f: (file.ord - 2).chr, r: rank - 1 }]
      end

      def top_left(file, rank)
        [{ f: (file.ord - 2).chr, r: rank + 1 },
         { f: (file.ord - 1).chr, r: rank + 2 }]
      end

      def prune_oob_squares(starts)
        starts.delete_if do |square|
          valid_square?(square[:f], square[:r]) == false
        end
      end

      def valid_square?(file, rank)
        BoardStandards::FILES.include?(file) && 1 <= rank && rank <= 8
      end
    end
  end

end
