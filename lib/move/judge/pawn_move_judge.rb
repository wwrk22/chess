require_relative './move_judge'
require './lib/move/pawn_move'


class PawnMoveJudge < MoveJudge
  def judge_move(move, board)
    # Case: Move is not a capture and there is only one possible starting
    # square.
    # e.g. a2 to a3
    if move.capture == false
      if move.starts.size == 1
        target_empty = check_target(move.target, board)
        start_has_pawn = check_target(move.starts[0], board, move.moving_piece)
        return target_empty && start_has_pawn
      end
    end
  end
end
