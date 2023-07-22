require './lib/move/move'


class MoveJudge

  def check_square(square, board, color = nil, type = nil)
    if color.nil? && type.nil?
      return board.at(square[:file], square[:rank]).nil?
    end
  end

  def check_target(target_square, board, target = nil)
    target_file = target_square[:file]
    target_rank = target_square[:rank]
    actual_target = board.at(target_file, target_rank)

    return actual_target.nil? if target.nil?
    return (actual_target.nil?) ? false : (actual_target == target)
  end

  # Check to see if the path between the starting square 'a', and the ending
  # square 'b' is clear. The 'direction' tells which way to go from 'a'.
  def clear_path?(a, b, board, direction)
    if square_on_path?(a, b, direction)
      return traverse_path(a, direction[:file], direction[:rank], board)
    else
      return false
    end
  end


  private
  
  def square_on_path?(a, b, direction)
    end_file = (a[:file].ord + direction[:file]).chr
    end_rank = a[:rank] + direction[:rank]
    return b[:file] == end_file && b[:rank] == end_rank
  end

  def traverse_path(a, files, ranks, board)
    files, ranks = [update_steps(files), update_steps(ranks)]

    until files == 0 && ranks == 0 do
      return false if empty_square?(a, files, ranks, board) == false
      files, ranks = [update_steps(files), update_steps(ranks)]
    end

    return true
  end

  def empty_square?(a, files, ranks, board)
    file_to_check = (a[:file].ord + files).chr
    rank_to_check = a[:rank] + ranks
    return board.at(file_to_check, rank_to_check) == nil
  end

  def update_steps(steps)
    (steps > 0) ? (steps -= 1) : ((steps < 0) ? (steps += 1) : steps)
  end


end
