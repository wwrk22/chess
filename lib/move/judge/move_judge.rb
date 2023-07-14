require './lib/move/move'


class MoveJudge

  def check_target(target_square, board, target = nil)
    target_file = target_square[:file]
    target_rank = target_square[:rank]
    actual_target = board.at(target_file, target_rank)

    return actual_target.nil? if target.nil?
    return actual_target == target if actual_target.nil? == false
  end

  # Check to see if the path between the starting square 'a', and the ending
  # square 'b' is clear. The 'direction' tells which way to go from 'a'.
  def clear_path?(a, b, board, direction)
    file_steps, rank_steps = [direction[:file], direction[:rank]]

    end_file = (a[:file].ord + direction[:file]).chr
    end_rank = a[:rank] + direction[:rank]
    if b[:file] != end_file || b[:rank] != end_rank
      return false
    end

#    until file_steps == 0 && rank_steps == 0 do
#      
#    end
  end


end
