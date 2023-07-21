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
    if mid_sq_empty?(target_sq, pawn_color, board)
      return judge_single_move(target_sq, start_sq, pawn_color, board)
    else
      return false
    end
  end

  private

  def mid_sq_empty?(target_sq, pawn_color, board)
    if pawn_color == ChessPiece::WH
      return board.at(target_sq[:file], target_sq[:rank] - 1).nil?
    else
      return board.at(target_sq[:file], target_sq[:rank] + 1).nil?
    end
  end
end
