require './lib/standard/chess_piece'


# Computes the required information for use by the chess board in order to
# perform a move.
class PawnComputer
  
  # Compute at most two possible starting squares for a non-capture move.
  def compute_non_capture(target, player_color, starts = [])
    compute_non_capture_white(target, starts) if player_color == ChessPiece::WH
    compute_non_capture_black(target, starts) if player_color == ChessPiece::BL
    starts
  end

  
  private

  def compute_non_capture_white(target, starts)
    starts << { file: target[:file], rank: target[:rank] - 1 }
    starts << { file: target[:file], rank: 2 } if target[:rank] == 4
  end

  def compute_non_capture_black(target, starts)
    starts << { file: target[:file], rank: target[:rank] + 1 }
    starts << { file: target[:file], rank: 7 } if target[:rank] == 5
  end

end
