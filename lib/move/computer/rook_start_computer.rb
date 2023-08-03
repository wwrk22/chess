require './lib/board/board_specs'
require './lib/move/computer/start_computer'
require './lib/piece/rook_specs'


class RookStartComputer < StartComputer
  include BoardSpecs

  # Compute the starting square only if a valid starting file or rank is given.
  def compute_move_old(target_square, start_place)
    start_file, start_rank = [target_square[:file], target_square[:rank]]
    start_file = start_place if valid_file? start_place
    start_rank = start_place if valid_rank? start_place

    start = { file: start_file, rank: start_rank }
    (start == target) ? nil : start
  end

  ##
  # Accept a Move object and a copy of the Board to return the starting square
  # of a rook. If the starting square cannot be computed, return nil.
  def compute_move(move, board, start_place = nil)
    if start_place.nil?
      return check_multiple_paths(move, board, RookSpecs::DIRECTIONS)
    else
      return compute_with_start_place(move.target, start_place)
    end
  end
end
