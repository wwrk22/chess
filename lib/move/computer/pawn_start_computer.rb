require_relative './start_computer'
require './lib/piece/piece_specs'


# Compute the starting square of the moving pawn.
class PawnStartComputer < StartComputer
  include PieceSpecs
 
  # Updated #compute_capture
  # 1. Accept the params Move, Board
  # 2. Use Move.start_coordinate, Move.target, and Move.color to determine
  #    the starting square
  # 3. Confirm that the moving piece, as determined by Move.pice and Move.color
  #    , is at the square on the board.
  # Return true if 3 is true, false otherwise
  def compute_capture_start(color, start_coordinate, target)
    rank_diff = (color == white) ? -1 : 1
    { file: start_coordinate, rank: target[:rank] + rank_diff }
  end

  def compute_capture(move, board)
    compute_args = [move.color, move.start_coordinate, move.target]
    start_square = compute_capture_start(*compute_args)
    check_start(start_square, move.piece, board)
  end
end
