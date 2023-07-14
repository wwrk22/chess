require './lib/move/pawn_move'


class PawnMoveJudge

  def check_target(target_square, board, target_color = nil)
    target_file = target_square[:file]
    target_rank = target_square[:rank]
    target = board.at(target_file, target_rank)

    return target.nil? if target_color.nil?
    return target[:color] == target_color if target.nil? == false
  end

end
