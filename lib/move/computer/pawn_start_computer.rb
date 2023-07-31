require './lib/piece/piece_specs'


# Compute the starting square of the moving pawn.
class PawnStartComputer
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

  def cc(move, board)
    start_square = compute_capture_start

    start = board.at(start_square[:file], start_square[:rank])
    if start.nil? == false && start.type == move.piece && start.color == move.color
      move.start = start_square
    end
  end
end
