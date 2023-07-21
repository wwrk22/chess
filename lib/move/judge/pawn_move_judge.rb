require_relative './move_judge'
require './lib/move/pawn_move'


class PawnMoveJudge < MoveJudge
  ##
  # If the target square is empty and the start square has the moving pawn,
  # then return true. Return false for all other cases.
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

  ##
  # Return false if the target square is empty or has the player's own chess
  # piece. Otherwise, determine the start square with `start_file` and return
  # true if the square has the player's pawn, or false if it doesn't.
  def judge_capture(target_sq, start_file, pawn_color, board)
    target = board.at(target_sq[:file], target_sq[:rank])
    return false if target.nil? || target[:color] == pawn_color

    start_rank = compute_start_rank(target_sq[:rank], pawn_color)
    start_sq = { file: start_file, rank: start_rank }
    check_target(start_sq, board, { type: ChessPiece::PA, color: pawn_color })
  end

  def judge_ep_capture(target_sq, start_file, pawn_color, board)
    if pawn_color == ChessPiece::WH
      ep_sq = { file: target_sq[:file], rank: target_sq[:rank] - 1 }
      
      if check_target(ep_sq, board, { type: ChessPiece::PA, color: ChessPiece::BL })
        return judge_capture(target_sq, start_file, ChessPiece::WH, board)
      else
        return false
      end
    end

    if pawn_color == ChessPiece::BL
      ep_sq = { file: target_sq[:file], rank: target_sq[:rank] + 1 }
      if check_target(ep_sq, board, { type: ChessPiece::PA, color: ChessPiece::WH })
        return judge_capture(target_sq, start_file, ChessPiece::BL, board)
      else
        return false
      end
    end
  end

  private

  ##
  # Simply determine the rank of the starting square of a capturing pawn.
  def compute_start_rank(target_rank, pawn_color)
    return pawn_color == ChessPiece::WH ? target_rank - 1 : target_rank + 1
  end

  ##
  # Determine whether the square "before" the target square is empty depending
  # on the player's color.
  def mid_sq_empty?(target_sq, pawn_color, board)
    if pawn_color == ChessPiece::WH
      return board.at(target_sq[:file], target_sq[:rank] - 1).nil?
    else
      return board.at(target_sq[:file], target_sq[:rank] + 1).nil?
    end
  end
end
