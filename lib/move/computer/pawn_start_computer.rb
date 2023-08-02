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

  def compute_move(move, board)
    first_square = check_first(move, board)
    return first_square if first_square

    second_square = check_second(move, board)
    return second_square if second_square
  end

  private

  def check_first(move, board)
    rank_diff = (move.piece.color == white) ? -1 : 1
    check_for_pawn(move, board, rank_diff)
  end

  def check_second(move, board)
    rank_diff = (move.piece.color == white) ? -1 : 1
    if check_double(move, board, rank_diff)
      return check_for_pawn(move, board, rank_diff * 2)
    end
  end

  def check_double(move, board, rank_diff)
    board.at(move.target[:file], move.target[:rank] + rank_diff).nil? &&
    ((move.piece.color == white && move.target[:rank] == 4) ||
    (move.piece.color == black && move.target[:rank] == 5))
  end

  def check_for_pawn(move, board, rank_diff)
    square = { file: move.target[:file], rank: move.target[:rank] + rank_diff }
    piece = board.at(square[:file], square[:rank])
    return square if piece.eql?(move.piece)
  end
end
