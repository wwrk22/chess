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
end
