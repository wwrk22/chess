require_relative './move_judge'
require './lib/move/pawn_move'


class PawnMoveJudge < MoveJudge
  def judge_single_move(target_sq, start_sq, pawn_color, board)
    file, rank = [target_sq[:file], target_sq[:rank]]
    pawn = { type: ChessPiece::PA, color: pawn_color }

    (board.at(file, rank).nil?) ? check_target(start_sq, board, pawn) : false
  end

  def judge_double_move(target_sq, start_sq, pawn_color, board)
  end
end
