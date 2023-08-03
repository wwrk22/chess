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

  ##
  # Compute the starting square of a bishop with the given starting coordinate.
  # Return the square if the bishop is on the square. Otherwise, return nil.
  def compute_with_start_coordinate(target_square, start_coordinate, board, moving_bishop)
    starting_squares = (valid_file? start_coordinate) ?
      compute_with_file(target_square, start_coordinate) :
      compute_with_rank(target_square, start_coordinate)

    starting_squares.filter! { |square| valid_start?(square, board) }
    starting_squares[0] if starting_squares.size == 1
  end

  ##
  # Compute the one or two possible starting squares with the given starting
  # file.
  def compute_with_file(target_square, start_file)
    starting_ranks = compute_start_ranks(target_square, start_file)

    starting_ranks.map do |rank|
      { file: start_file, rank: rank } if valid_rank? rank
    end
  end

  ##
  # Compute the one or two possible starting squares with the given starting
  # rank.
  def compute_with_rank(target_square, start_rank)
    starting_files = compute_start_files(target_square, start_rank)

    starting_files.map do |file|
      { file: file, rank: start_rank } if valid_file? file
    end
  end

  
  private
  
  ##
  # Compute the ranks of the two possible starting squares for a move to the
  # given target square from the given starting file. The computed ranks are
  # not always valid.
  def compute_start_ranks(target_square, start_file)
    rank_diff = (target_square[:file].ord - start_file.ord).abs
    [target_square[:rank] - rank_diff, target_square[:rank] + rank_diff]
  end

  ##
  # Compute the files of the two possible starting squares for a move to the
  # given target square from the given starting rank. The computed files are
  # not always valid.
  def compute_start_files(target_square, start_rank)
    file_diff = (target_square[:rank] - start_rank).abs
    [(target_square[:file].ord - file_diff).chr,
     (target_square[:file].ord + file_diff).chr]
  end
end
