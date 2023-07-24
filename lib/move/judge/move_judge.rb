require './lib/move/move'


class MoveJudge
  ##
  # Return true if the move defined by parameters is legal, false otherwise.
  # Starting square is checked for the moving piece, target square is checked
  # for emptiness, and the path between the two is checked for emptiness if the
  # parameter `check_path` is true.
  def judge_move(move_data, board)
    target = move_data.target

    if board.at(target[:file], target[:rank]).nil?
      return false
    else
    end
  end

  ##
  # Check a square to see if it's empty or if it has a chess piece of either
  # specified type or color, or both. Return true if matched, false otherwise.
  def check_square(square, board, color = nil, type = nil)
    target = board.at(square[:file], square[:rank])
    chess_piece_to_find = { type: type, color: color }

    return target.nil? if color.nil? && type.nil?
    return target == chess_piece_to_find if type
    return target.nil? ? false : target[:color] == color
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
