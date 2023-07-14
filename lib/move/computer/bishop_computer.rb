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


  end
end
