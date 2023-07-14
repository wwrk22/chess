require './lib/move/move'


class MoveJudge

  def check_target(target_square, board, target = nil)
    target_file = target_square[:file]
    target_rank = target_square[:rank]
    actual_target = board.at(target_file, target_rank)

    return actual_target.nil? if target.nil?
    return actual_target == target if actual_target.nil? == false
  end

end
