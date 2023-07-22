require_relative './move_judge'
require './lib/standard/chess_piece'
require './lib/board/board'
require './lib/board/board_computer'


class RookMoveJudge < MoveJudge
  include BoardComputer

  def judge_move(start_sq, target_sq, player_color, board)
    return false if board.at(target_sq[:file], target_sq[:rank]).nil? == false

    direction = compute_direction(start_sq, target_sq)
    rook = { type: ChessPiece::RO, color: player_color }

    return check_target(start_sq, board, rook) ?
      clear_path?(start_sq, target_sq, board, direction) : false
  end
end
