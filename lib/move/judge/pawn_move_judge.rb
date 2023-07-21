require_relative './move_judge'
require './lib/move/pawn_move'


class PawnMoveJudge < MoveJudge
  def judge_single_move(target_sq, start_sq, pawn_color, board)
    file, rank = [target_sq[:file], target_sq[:rank]]
    pawn = { type: ChessPiece::PA, color: pawn_color }

    (board.at(file, rank).nil?) ? check_target(start_sq, board, pawn) : false
  end

  ##
  # First, check to see if the square between the target and the start is
  # empty. If so, then call #judge_single_move on the target and start to
  # determine move legality.
  # Otherwise, return false to indicate middle square is not empty.
  def judge_double_move(target_sq, start_sq, pawn_color, board)
    if pawn_color == ChessPiece::WH
      middle_sq_rank = target_sq[:rank] - 1

      if board.at(target_sq[:file], middle_sq_rank).nil? == false
        return false
      end
    end
  end
end
