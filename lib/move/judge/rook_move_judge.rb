require_relative './move_judge'
require './lib/standard/chess_piece'
require './lib/board/board'
require './lib/board/board_computer'


class RookMoveJudge < MoveJudge
  include BoardComputer

  def judge_move(start_sq, target_sq, player_color, board)
    if board.at(target_sq[:file], target_sq[:rank]).nil?
      player_rook = { type: ChessPiece::RO, color: player_color }

      if check_target(start_sq, board, player_rook)
        direction = compute_direction(start_sq, target_sq)
        return clear_path?(start_sq, target_sq, board, direction)
      end
    end

    return false
  end
end
