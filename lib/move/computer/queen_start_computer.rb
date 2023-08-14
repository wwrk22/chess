require_relative 'start_computer'
require './lib/standard/chess_board'
require './lib/piece/queen_specs'


class QueenStartComputer < StartComputer
  include ChessBoard
 
  ##
  # Accept a Move object and a copy of the Board to return the starting square
  # of a queen. If the starting square cannot be computed, return nil.
  def compute_start(move, board)
    return nil if move.piece.nil? || move.target.nil?

    if move.start_coordinate.nil?
      return check_multiple_paths(move, board, QueenSpecs::DIRECTIONS)
    else
      return compute_with_start_coordinate(move, board)
    end
  end

  def compute_with_start_coordinate(move, board)
    if on_target_axes?(move.start_coordinate, move.target)
      return start_on_target_axes(move, board)
    else
      return start_off_target_axes(move, board)
    end
  end

  ##
  # Compute the starting square of the queen with the given starting coordinate
  # when it is the same as either the file or rank of the target square.
  # Return the square if the queen is on the square. Otherwise, return nil.
  def start_on_target_axes(move, board)
    directions = valid_file?(move.start_coordinate) ?
      [{ file: 0, rank: 1 }, { file: 0, rank: -1 }] :
      [{ file: 1, rank: 0 }, { file: -1, rank: 0 }]

    check_multiple_paths(move, board, directions)
  end

  ##
  # Compute the starting square of a queen with the given starting coordinate.
  # Return the square if the queen is on the square. Otherwise, return nil.
  def start_off_target_axes(move, board)
    starting_squares = (valid_file? move.start_coordinate) ?
      compute_starts_with_file(move.target, move.start_coordinate) :
      compute_starts_with_rank(move.target, move.start_coordinate)

    starting_squares.filter! { |square| valid_start?(move, board, square) }
    starting_squares[0] if starting_squares.size == 1
  end

  ##
  # Compute the ranks of the three possible starting squares for a move to the
  # given target square from the given starting file. The computed ranks are
  # not always valid and their validity should be checked by the caller of this
  # method.
  def compute_start_ranks(target_square, start_file)
    rank_diff = (target_square[:file].ord - start_file.ord).abs
    [target_square[:rank] - rank_diff,
     target_square[:rank],
     target_square[:rank] + rank_diff]
  end

  ##
  # Compute the files of the three possible starting squares for a move to the
  # given target square from the given starting rank. The computed files are
  # not always valid and their validity should be checked by the caller of this
  # method.
  def compute_start_files(target_square, start_rank)
    file_diff = (target_square[:rank] - start_rank).abs
    [(target_square[:file].ord - file_diff).chr,
      target_square[:file],
     (target_square[:file].ord + file_diff).chr]
  end

  ##
  # Compute the possible starting squares of a move with the given starting
  # file.
  def compute_starts_with_file(target_square, start_file)
    starting_ranks = compute_start_ranks(target_square, start_file)

    starting_ranks.map do |rank|
      { file: start_file, rank: rank } if valid_rank? rank
    end
  end

  ##
  # Compute the possible starting squares of a move with the given starting
  # rank.
  def compute_starts_with_rank(target_square, start_rank)
    starting_files = compute_start_files(target_square, start_rank)

    starting_files.map do |file|
      { file: file, rank: start_rank } if valid_file? file
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
