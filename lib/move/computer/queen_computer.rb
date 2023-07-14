require './lib/standard/chess_board'


class QueenComputer
  include ChessBoard

  # Compute all starting squares with the given starting file or rank.
  def compute_move(target, start_place)
    if valid_file? start_place
      return compute_with_file(target, start_place)
    end

    if valid_rank? start_place
      return compute_with_rank(target, start_place)
    end
  end

  private

  def compute_with_file(target, start_file, starts = [])
    diff = (target[:file].ord - start_file.ord).abs
    starts << { file: start_file, rank: target[:rank] + diff }
    starts << { file: start_file, rank: target[:rank] }
    starts << { file: start_file, rank: target[:rank] - diff }
    prune_squares(starts)
  end

  def compute_with_rank(target, start_rank, starts = [])
    diff = (target[:rank] - start_rank).abs
    starts << { file: (target[:file].ord - diff).chr, rank: start_rank }
    starts << { file: target[:file], rank: start_rank }
    starts << { file: (target[:file].ord + diff).chr, rank: start_rank }
    prune_squares(starts)
  end

  # Remove all squares with out-of-bounds files and/or ranks from the array of
  # squares, then return the array.
  def prune_squares(squares)
    return squares.reduce([]) do |pruned, square|
      file, rank = [square[:file], square[:rank]]
      pruned << square if valid_file?(file) && valid_rank?(rank)
      pruned
    end
  end
end
