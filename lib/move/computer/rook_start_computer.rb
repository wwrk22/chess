require './lib/board/board_specs'
require './lib/move/computer/start_computer'
require './lib/piece/rook_specs'


class RookStartComputer < StartComputer
  include BoardSpecs

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
