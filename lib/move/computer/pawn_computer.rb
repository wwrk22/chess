require './lib/standard/chess_piece'


# Computes the required information for use by the chess board in order to
# perform a move.
class PawnComputer
  
  # Compute at most two possible starting squares for a non-capture move.
  def compute_non_capture(target, player_color, starts = [])
    target_file, target_rank = [target[:file], target[:rank]]

    # Single move
    if player_color == ChessPiece::WH && rank_not_four?(target_rank)
      start_file, start_rank = [target_file, target_rank - 1]
      starts << { file: start_file, rank: start_rank }
    end

    # Double move


    return starts
  end


  private

  def rank_not_four?(rank)
    rank != 4 && 1 < rank
  end
end
