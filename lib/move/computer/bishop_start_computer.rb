require './lib/standard/chess_board'
require './lib/piece/bishop_specs'


class BishopStartComputer
  include ChessBoard
  
  ##
  # Accept a Move object and a copy of the Board to return the starting square
  # of a bishop. If the starting square cannot be computed, return nil.
  def compute_move(move, board, start_place = nil)
    if start_place.nil?
      return check_multiple_paths(move, board, BishopSpecs::DIRECTIONS)
    else
      return compute_with_start_place(move.target, start_place)
    end
  end
end
