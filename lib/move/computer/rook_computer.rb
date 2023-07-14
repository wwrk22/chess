require './lib/standard/chess_board'


class RookComputer
  include ChessBoard

  # Compute the starting square only if a valid starting file or rank is given.
  def compute_move(target, start_place)
    start_file, start_rank = [target[:file], target[:rank]]
    start_file = start_place if valid_file? start_place
    start_rank = start_place if valid_rank? start_place
    start = { file: start_file, rank: start_rank }
    return (start == target) ? nil : [start]
  end
end
