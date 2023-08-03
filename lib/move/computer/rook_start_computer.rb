require './lib/board/board_specs'
require './lib/move/computer/start_computer'
require './lib/piece/rook_specs'


class RookStartComputer < StartComputer
  include BoardSpecs

  ##
  # Accept a Move object and a copy of the Board to return the starting square
  # of a rook. If the starting square cannot be computed, return nil.
  def compute_move(move, board, start_coordinate = nil)
    if start_coordinate.nil?
      return check_multiple_paths(move, board, RookSpecs::DIRECTIONS)
    else
      return compute_with_start_coordinate(move.target, start_coordinate)
    end
  end

  ##
  # Compute the starting square of the rook with the given starting coordinate.
  # Return the square if the rook is on the square. Otherwise, return nil.
  def compute_with_start_coordinate(target_square, start_coordinate, board, moving_rook)
    start_square = valid_file?(start_coordinate) ?
      { file: start_coordinate, rank: target_square[:rank] } :
      { file: target_square[:file], rank: start_coordinate }

    piece = board.at(start_square[:file], start_square[:rank])
    piece.eql?(moving_rook) ? start_square : nil
  end
end
