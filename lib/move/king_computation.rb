require './lib/standards/board_standards'

# The lambda MOVE contains the logic for determining all possible starting
# squares for king moves.
module KingComputation

  MOVE = ->(data) do
    starts = Helper.same_rank(data[:target])
    starts += Helper.rank_above(data[:target]) if data[:target][:r] < 8
    starts += Helper.rank_below(data[:target]) if data[:target][:r] > 1
    starts
  end

  private

  module Helper
    class << self
      # Return the two start squares on either side of the target square.
      def same_rank(target, starts = [])
        left_f, right_f = [(target[:f].ord - 1).chr, (target[:f].ord + 1).chr]
        starts << { f: left_f, r: target[:r] } if file_valid? left_f
        starts << { f: right_f, r: target[:r] } if file_valid? right_f
      end

      # Return the three start squares on the rank one higher than the target
      # square's rank.
      def rank_above(target, starts = [{ f: target[:f], r: target[:r] + 1 }])
        left_f, right_f = [(target[:f].ord - 1).chr, (target[:f].ord + 1).chr]
        starts << { f: left_f, r: target[:r] + 1 } if file_valid? left_f
        starts << { f: right_f, r: target[:r] + 1 } if file_valid? right_f
      end

      # Return the three start squares on the rank one lower than the target
      # square's rank.
      def rank_below(target, starts = [{ f: target[:f], r: target[:r] - 1 }])
        left_f, right_f = [(target[:f].ord - 1).chr, (target[:f].ord + 1).chr]
        starts << { f: left_f, r: target[:r] - 1 } if file_valid? left_f
        starts << { f: right_f, r: target[:r] - 1 } if file_valid? right_f
      end

      def file_valid?(f)
        BoardStandards::FILES.include? f
      end
    end
  end # module Helper
end
