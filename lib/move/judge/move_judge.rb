require './lib/move/move'
require './lib/board/board_computer'


class MoveJudge
  include BoardComputer

  ##
  # Return true if the move defined by parameters is legal, false otherwise.
  # Starting square is checked for the moving piece, target square is checked
  # for emptiness, and the path between the two is checked for emptiness if the
  # parameter `check_path` is true.
  def judge_move(move, board)
    target = board.at(move.target[:file], move.target[:rank])
    return false if target.nil? == false

    direction = compute_direction(move.start, move.target)
    return board.at(move.start[:file], move.start[:rank]) == move.piece &&
      clear_path?(move.start, move.target, board, direction)
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
    return true if direction.nil?
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
