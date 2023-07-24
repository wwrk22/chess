require_relative './move_judge'
require './lib/standard/chess_piece'
require './lib/board/board'
require './lib/board/board_computer'


class RookMoveJudge < MoveJudge
  include BoardComputer

  def judge_move(start_sq, target_sq, player_color, board)
    return false if board.at(target_sq[:file], target_sq[:rank]).nil? == false
    return rook_path_clear?(start_sq, target_sq, player_color, board)
  end


  private

  def rook_path_clear?(start_sq, target_sq, player_color, board)
    direction = compute_direction(start_sq, target_sq)

    return check_square(start_sq, board, player_color, ChessPiece::RO) ?
      clear_path?(start_sq, target_sq, board, direction) : false
  end
end
