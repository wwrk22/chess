require './lib/standard/chess_board'


class BishopComputer
  include ChessBoard
  
  # Compute the two starting squares only if a valid starting file or rank is given.
  def compute_move(target, start_place)
    return compute_with_file(target, start_place) if valid_file? start_place
    return compute_with_rank(target, start_place) if valid_rank? start_place
  end

  
  private

  def compute_with_file(target, start_file, starts = [])
    file_diff = (target[:file].ord - start_file.ord).abs
    starts << { file: start_file, rank: target[:rank] + file_diff }
    starts << { file: start_file, rank: target[:rank] - file_diff }
    starts
  end

  def compute_with_rank(target, start_rank, starts = [])
    rank_diff = (target[:rank] - start_rank).abs
    starts << { file: (target[:file].ord - rank_diff).chr, rank: start_rank }
    starts << { file: (target[:file].ord + rank_diff).chr, rank: start_rank }
    starts
  end
end
