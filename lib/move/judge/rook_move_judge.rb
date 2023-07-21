require_relative './move_judge'
require './lib/standard/chess_piece'
require './lib/board/board'


class RookMoveJudge < MoveJudge
  def judge_move(start_sq, target_sq, player_color, board)
    if board.at(target_sq[:file], target_sq[:rank]).nil?
      player_rook = { type: ChessPiece::RO, color: player_color }

      if check_target(start_sq, board, player_rook).nil?
        return false
      else

      end
    else
      return false
    end
  end
end
