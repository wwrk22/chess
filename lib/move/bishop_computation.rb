module BishopComputation

  MOVE = ->(data) do
    return Helper.starts_for_file(data) if data[:start_f]
    return Helper.starts_for_rank(data) if data[:start_r]
    return Helper.all_starts(data)
  end

  private
  
  module Helper
    class << self
      def starts_for_file(data, starts = [])
        diff = (data[:target][:f].ord - data[:start_f].ord).abs
        starts.concat([{ f: data[:start_f], r: data[:target][:r] - diff },
                       { f: data[:start_f], r: data[:target][:r] + diff }])
      end

      def starts_for_rank(data, starts = [])
        diff = (data[:target][:r] - data[:start_r]).abs
        left_sq = { f: (data[:target][:f].ord - diff).chr, r: data[:start_r] }
        right_sq = { f: (data[:target][:f].ord + diff).chr, r: data[:start_r] }
        starts.concat([left_sq, right_sq])
      end

      def all_starts(data, line = [])
        line_a = get_diagonal_a(data[:target])
        line_b = get_diagonal_b(data[:target])
        line_a.concat(line_b)
      end

      # Return an array of all squares on the diagonal line through the given
      # square, going from bottom left to top right.
      def get_diagonal_a(square, line = [])
        go_bottom_left(square[:f], square[:r], line)
        go_top_right((square[:f].ord + 1).chr, square[:r] + 1, line)
        line
      end

      # Return an array of all squares on the diagonal line through the given
      # square, going from top left to bottom right.
      def get_diagonal_b(square, line = [])
        go_top_left((square[:f].ord - 1).chr, square[:r] + 1, line)
        go_bottom_right((square[:f].ord + 1).chr, square[:r] - 1, line)
        line
      end

      def go_bottom_left(file, rank, line)
        until rank == 0 || file.ord == 96 do
          line << { f: file, r: rank }
          file = (file.ord - 1).chr
          rank -= 1
        end
      end

      def go_top_right(file, rank, line)
        until rank == 9 || file.ord == 105 do
          line << { f: file, r: rank }
          file = (file.ord + 1).chr
          rank += 1
        end
      end

      def go_top_left(file, rank, line)
        until rank == 9 || file.ord == 96 do
          line << { f: file, r: rank }
          file = (file.ord - 1).chr
          rank += 1
        end
      end

      def go_bottom_right(file, rank, line)
        until rank == 0 || file.ord == 105 do
          line << { f: file, r: rank }
          file = (file.ord + 1).chr
          rank -= 1
        end
      end

    end # class << self
  end # module Helper

end
