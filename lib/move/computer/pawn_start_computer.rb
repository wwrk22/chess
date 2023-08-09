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

  def calculate_limit(pawn_color, target_rank)
    return (pawn_color == white && target_rank == 4) ||
           (pawn_color == black && target_rank == 5) ?
           2 : 1
  end

  def compute_start(move, board)
    return compute_capture(move, board) if move.capture

    rank_diff = (move.piece.color == white) ? -1 : 1

    first_square = check_first(move, board, rank_diff)
    return first_square if first_square

    check_second(move, board, rank_diff) if check_double(move, board, rank_diff)
  end

  private

  def check_first(move, board, rank_diff)
    start = { file: move.target[:file], rank: move.target[:rank] + rank_diff }
    start if check_start(start, move.piece, board)
  end

  def check_second(move, board, rank_diff)
    start = { file: move.target[:file], rank: move.target[:rank] + 2 * rank_diff }
    start if check_start(start, move.piece, board)
  end

  def check_double(move, board, rank_diff)
    first_square = { file: move.target[:file], rank: move.target[:rank] + rank_diff }
    board.at(first_square).nil? &&
    ((move.piece.color == white && move.target[:rank] == 4) ||
    (move.piece.color == black && move.target[:rank] == 5))
  end
end
