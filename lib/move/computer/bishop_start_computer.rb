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
    # Find the two possible starting squares.
    # Return the one square that has the moving bishop.
    # Return nil if neither has the moving bishop.
    #starting_square = foo()

    #starting_square(proc {}) { |square| board.at(square[:file], square[:rank]).
  end

  def compute_with_file(target_square, start_file)
    starting_ranks = compute_start_ranks(target_square, start_file)

    starting_ranks.map do |rank|
      { file: start_file, rank: rank } if valid_rank? rank
    end
  end

  def compute_with_rank(target_square, start_coordinate)
  end

  
  private
  
  def compute_start_ranks(target_square, start_file)
    rank_diff = (target_square[:file].ord - start_file.ord).abs
    [target_square[:rank] - rank_diff, target_square[:rank] + rank_diff]
  end
end
