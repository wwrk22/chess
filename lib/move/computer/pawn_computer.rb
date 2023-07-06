require './lib/standard/chess_piece'


# Computes the required information for use by the chess board in order to
# perform a move.
class PawnComputer
  
  # Compute at most two possible starting squares for a non-capture move.
  def compute_non_capture(target, player_color, starts = [])
    target_file, target_rank = [target[:file], target[:rank]]

    if player_color == ChessPiece::WH
      starts << { file: target_file, rank: target_rank - 1 }

      if target_rank == 4
        starts << { file: target_file, rank: 2 }
      end
    end

    return starts
  end


end
