require_relative './start_computer'
require './lib/piece/piece_specs'


# Compute the starting square of the moving pawn.
class PawnStartComputer < StartComputer
  include PieceSpecs
 
  def compute_capture_start(color, start_coordinate, target)
    rank_diff = (color == white) ? -1 : 1
    { file: start_coordinate, rank: target[:rank] + rank_diff }
  end

  ##
  # Return the starting square of the moving pawn for a capturing move.
  def compute_capture(move, board)
    compute_args = [move.piece.color, move.start_coordinate, move.target]
    start_square = compute_capture_start(*compute_args)
    start_square if check_start(start_square, move.piece, board)
  end

  def compute_move(move, board)
    color, target_file, target_rank = [move.piece.color, move.target[:file], move.target[:rank]]
    rank_diff = (move.piece.color == white) ? -1 : 1
    
    first_start = compute_start_square(rank_diff, move, board)
    return first_start if first_start

    first_start_empty = board.at(target_file, target_rank + rank_diff).nil?
    white_double = (color == white) && (target_rank == 4)
    black_double = (color == black) && (target_rank == 5)

    if first_start_empty && (white_double || black_double)
      second_start = compute_start_square(rank_diff * 2, move, board)
      return second_start if second_start
    end
  end

  private

  def compute_start_square(rank_diff, move, board)
    target_file, target_rank = [move.target[:file], move.target[:rank]]
    pawn = board.at(target_file, target_rank + rank_diff)

    { file: target_file, rank: target_rank + rank_diff } if pawn.eql? move.piece
  end
end
