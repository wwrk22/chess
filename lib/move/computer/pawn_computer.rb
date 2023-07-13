require './lib/standard/chess_piece'


# Computes the required information for use by the chess board in order to
# perform a move with a pawn.
class PawnComputer
  
  # Compute at most two possible starting squares for a non-capture move.
  def compute_non_capture(target, player_color, starts = [])
    if player_color == ChessPiece::WH
      return compute_non_capture_white(target, starts)
    else
      return compute_non_capture_black(target, starts)
    end
  end

  # Compute the one starting square for a capture move.
  def compute_capture(target, start_file, player_color, starts = [])
    if player_color == ChessPiece::WH
      return compute_capture_white(target, start_file, starts) 
    else
      return compute_capture_black(target, start_file, starts)
    end
  end

  
  private

  def compute_non_capture_white(target, starts)
    starts << { file: target[:file], rank: target[:rank] - 1 }
    starts << { file: target[:file], rank: 2 } if target[:rank] == 4
    starts
  end

  def compute_non_capture_black(target, starts)
    starts << { file: target[:file], rank: target[:rank] + 1 }
    starts << { file: target[:file], rank: 7 } if target[:rank] == 5
    starts
  end

  def compute_capture_white(target, start_file, starts)
    starts << { file: start_file, rank: target[:rank] - 1 }
  end

  def compute_capture_black(target, start_file, starts)
    starts << { file: start_file, rank: target[:rank] + 1 }
  end

end
