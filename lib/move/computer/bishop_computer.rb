require './lib/standard/chess_board'


class BishopComputer
  include ChessBoard
  
  # Compute the starting square only if a valid starting file or rank is given.
  def compute_move(target, start_place, starts = [])
    if valid_file? start_place
      file_diff = (target[:file].ord - start_place.ord).abs
      starts << { file: start_place, rank: target[:rank] + file_diff }
      starts << { file: start_place, rank: target[:rank] - file_diff }
    end

    if valid_rank? start_place
      rank_diff = (target[:rank] - start_place).abs
      starts << { file: (target[:file].ord - rank_diff).chr, rank: start_place }
      starts << { file: (target[:file].ord + rank_diff).chr, rank: start_place }
    end

    starts
  end
end
