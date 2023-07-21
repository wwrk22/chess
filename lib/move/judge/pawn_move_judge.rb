require_relative './move_judge'
require './lib/move/pawn_move'


class PawnMoveJudge < MoveJudge
  def judge_single_move(target_sq, start_sq, pawn_color, board)
    if board.at(target_sq[:file], target_sq[:rank]).nil?
      pawn = { type: ChessPiece::PA, color: pawn_color }
      return check_target(target_sq, board, pawn)
    else
      return false
    end
  end
end
