# Computes the required information for use by the chess board in order to
# perform a move with a knight.
class KnightComputer
  
  # Compute at most eight possible starting squares for a non-capture move.
  def compute_non_capture(target, starts = [])
    # top right
    compute_top_right(target, starts)
    # bottom right
    compute_bottom_right(target, starts)
    # bottom left
    compute_bottom_left(target, starts)
    # top left
    compute_top_left(target, starts)
    starts
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
