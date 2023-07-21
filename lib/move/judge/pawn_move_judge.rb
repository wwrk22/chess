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

      if move.starts.size == 2
        target_empty = check_target(move.target, board)
        first_start_has_pawn = check_target(move.starts[0], board, move.moving_piece)

        return true if target_empty && first_start_has_pawn

        second_start_has_pawn = check_target(move.starts[1], board, move.moving_piece)
        first_start_empty = check_target(move.starts[0], board)

        return true if target_empty && first_start_empty && second_start_has_pawn
      end
    end
  end
end
