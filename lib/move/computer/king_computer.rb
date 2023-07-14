require './lib/standard/chess_board'


class KingComputer
  include ChessBoard
  
  # Compute all of the at most eight possible starting squares.
  def compute_move(target, starts = [])
    left_file = (target[:file].ord - 1).chr
    right_file = (target[:file].ord + 1).chr
    rank = target[:rank] - 1

    until valid_rank?(rank) == false do
      starts << { file: left_file, rank: rank } if valid_file? left_file
      starts << { file: target[:file], rank: rank } if rank != target[:rank]
      starts << { file: right_file, rank: rank } if valid_file? right_file
      rank += 1
    end

    starts
  end
end
