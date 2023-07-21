require_relative './move_judge'
require './lib/standard/chess_piece'
require './lib/board/board'


class RookMoveJudge < MoveJudge
  def judge_move(start_sq, target_sq, player_color, board)
    if board.at(target_sq[:file], target_sq[:rank]).nil?
    else
      return false
    end
  end
end
