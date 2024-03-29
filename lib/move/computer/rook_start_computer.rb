require './lib/board/board_specs'
require './lib/move/computer/start_computer'
require './lib/piece/rook_specs'


class RookStartComputer < StartComputer
  include BoardSpecs

  ##
  # Accept a Move object and a copy of the Board to return the starting square
  # of a rook. If the starting square cannot be computed, return nil.
  def compute_start(move, board)
    return nil if move.piece.nil? || move.target.nil?

    if move.start_coordinate.nil?
      return check_multiple_paths(move, board, RookSpecs::DIRECTIONS)
    else
      return compute_with_start_coordinate(move, board)
    end
  end

  ##
  # Compute the starting square of the rook with the given starting coordinate.
  # Return the square if the rook is on the square. Otherwise, return nil.
  def start_off_target_axes(move, board)
    start_square = valid_file?(move.start_coordinate) ?
      { file: move.start_coordinate, rank: move.target[:rank] } :
      { file: move.target[:file], rank: move.start_coordinate }

    file_direction = start_square[:file].ord - move.target[:file].ord
    rank_direction = start_square[:rank] - move.target[:rank]

    file_direction = (file_direction > 0) ? 1 : (file_direction < 0 ? -1 : 0)
    rank_direction = (rank_direction > 0) ? 1 : (rank_direction < 0 ? -1 : 0)

    direction = { file: file_direction, rank: rank_direction }
    check_path(move, board, direction, start_square)
  end

  ##
  # Compute the starting square of the rook with the given starting coordinate
  # when it is the same as either the file or rank of the target square.
  # Return the square if the rook is on the square. Otherwise, return nil.
  def start_on_target_axes(move, board)
    directions = valid_file?(move.start_coordinate) ?
      [{ file: 0, rank: 1 }, { file: 0, rank: -1 }] :
      [{ file: 1, rank: 0 }, { file: -1, rank: 0 }]

    check_multiple_paths(move, board, directions)
  end

  def compute_with_start_coordinate(move, board)
    if on_target_axes?(move.start_coordinate, move.target)
      return start_on_target_axes(move, board)
    else
      return start_off_target_axes(move, board)
    end
  end


  private

  ##
  # Return true if the starting square coordinate is on the axes of the given
  # target square. Otherwise, return false.
  def on_target_axes?(start_coordinate, target_square)
    start_coordinate == target_square[:file] ||
    start_coordinate == target_square[:rank]
  end

end
