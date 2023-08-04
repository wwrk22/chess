require './lib/standard/chess_board'
require './lib/piece/queen_specs'


class QueenStartComputer
  include ChessBoard
 
  ##
  # Accept a Move object and a copy of the Board to return the starting square
  # of a queen. If the starting square cannot be computed, return nil.
  def compute_move(move, board)
    if move.start_coordinate.nil?
      return check_multiple_paths(move, board, QueenSpecs::DIRECTIONS)
    else
      return compute_with_start_coordinate(move, board)
    end
  end

  def compute_with_start_coordinate
  end
end
