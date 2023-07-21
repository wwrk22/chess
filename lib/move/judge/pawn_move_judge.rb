require_relative './move_judge'
require './lib/move/pawn_move'


class PawnMoveJudge < MoveJudge
  def judge_single_move(target_sq, start_sq, pawn_color, board)
    if board.at(target_sq[:file], target_sq[:rank]).nil?

    else
      return false
    end
  end
end
