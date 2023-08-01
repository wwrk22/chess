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

  ##
  # Return the starting square of the moving pawn for a non-capturing move.
  def compute_move(move, board)
    # WHITE
    # 1. Check the square directly below it
    #   a. If it's a white pawn then return the square
    #   b. If it's not a white pawn then move on.
    # 2. Check the square two below the target
    #   a. If it's a white pawn, then return the square
    #   b. If it's not a white pawn, then return nil.

    # BLACK
    # 1. Check the square directly above it
    #   a. If it's a black pawn then return the square
    #   b. If it's not a black pawn then move on.
    # 2. Check the square two above the target
    #   a. If it's a black pawn, then return the square
    #   b. If it's not a black pawn, then return nil.
  end
end
