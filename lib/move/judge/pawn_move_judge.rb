require_relative './move_judge'
require './lib/move/pawn_move'


class PawnMoveJudge < MoveJudge
  def judge_single_move(target_sq, start_sq, pawn_color, board)
    file, rank = [target_sq[:file], target_sq[:rank]]
    pawn = { type: ChessPiece::PA, color: pawn_color }

    return check_target(target_sq, board, pawn) if board.at(file, rank).nil?
    return false # if target square is not empty
  end
end
