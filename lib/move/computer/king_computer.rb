require './lib/standard/chess_board'


class KingComputer
  include ChessBoard
  
  # Compute all of the at most eight possible starting squares.
  def compute_move(target, starts = [])
    add_left_valid_squares((target[:file].ord - 1).chr, target[:rank] - 1, target[:rank], starts)
    add_mid_valid_squares(target[:file], target[:rank] - 1, target[:rank], starts)
    add_right_valid_squares((target[:file].ord + 1).chr, target[:rank] - 1, target[:rank], starts)
    starts
  end


  private

  def add_left_valid_squares(left_file, start_rank, target_rank, starts)
    while start_rank <= target_rank + 1 do
      if valid_file?(left_file) && valid_rank?(start_rank)
        starts << { file: left_file, rank: start_rank }
      end

      start_rank += 1
    end
  end
  
  def add_mid_valid_squares(mid_file, start_rank, target_rank, starts)
    while start_rank <= target_rank + 1 do
      if valid_rank?(start_rank) && start_rank != target_rank
        starts << { file: mid_file, rank: start_rank }
      end

      start_rank += 1
    end
  end

  def add_right_valid_squares(right_file, start_rank, target_rank, starts)
    while start_rank <= target_rank + 1 do
      if valid_file?(right_file) && valid_rank?(start_rank)
        starts << { file: right_file, rank: start_rank }
      end

      start_rank += 1
    end
  end
end
