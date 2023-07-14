require './lib/standard/chess_board'


# Computes the required information for use by the chess board in order to
# perform a move with a knight.
class KnightComputer
  include ChessBoard
  
  # Compute at most eight possible starting squares for a non-capture move.
  def compute_move(target, starts = [])
    compute_top_right(target, starts)
    compute_bottom_right(target, starts)
    compute_bottom_left(target, starts)
    compute_top_left(target, starts)
    prune_squares(starts)
  end

  # Remove all squares with out-of-bounds files and/or ranks from the array of
  # squares, then return the array.
  def prune_squares(squares)
    return squares.reduce([]) do |pruned, square|
      file, rank = [square[:file], square[:rank]]
      pruned << square if valid_file?(file) && valid_rank?(rank)
      pruned
    end
  end
  
  private

  def compute_top_right(target, starts)
    file, rank = [(target[:file].ord + 1).chr, target[:rank] + 2]
    starts << { file: file, rank: rank }
    file, rank = [(target[:file].ord + 2).chr, target[:rank] + 1]
    starts << { file: file, rank: rank }
  end

  def compute_bottom_right(target, starts)
    file, rank = [(target[:file].ord + 2).chr, target[:rank] - 1]
    starts << { file: file, rank: rank }
    file, rank = [(target[:file].ord + 1).chr, target[:rank] - 2]
    starts << { file: file, rank: rank }
  end

  def compute_bottom_left(target, starts)
    file, rank = [(target[:file].ord - 1).chr, target[:rank] - 2]
    starts << { file: file, rank: rank }
    file, rank = [(target[:file].ord - 2).chr, target[:rank] - 1]
    starts << { file: file, rank: rank }
  end

  def compute_top_left(target, starts)
    file, rank = [(target[:file].ord - 2).chr, target[:rank] + 1]
    starts << { file: file, rank: rank }
    file, rank = [(target[:file].ord - 1).chr, target[:rank] + 2]
    starts << { file: file, rank: rank }
  end
end
