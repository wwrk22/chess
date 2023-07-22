require_relative './move_judge'
require './lib/standard/chess_piece'
require './lib/board/board'
require './lib/board/board_computer'


class RookMoveJudge < MoveJudge
  include BoardComputer

  def judge_move(start_sq, target_sq, player_color, board)
    return false if board.at(target_sq[:file], target_sq[:rank]).nil? == false

    player_rook = { type: ChessPiece::RO, color: player_color }
    return rook_path_clear?(start_sq, target_sq, player_rook, board)
  end


  def judge_capture(start_sq, target_sq, player_color, board)
    
  end


  private

  def rook_path_clear?(start_sq, target_sq, player_rook, board)
    direction = compute_direction(start_sq, target_sq)

    if check_target(start_sq, board, player_rook)
      return clear_path?(start_sq, target_sq, board, direction)
    end

    false
  end
end
