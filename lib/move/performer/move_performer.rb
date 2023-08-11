require './lib/piece/piece_specs'
require './lib/board/board'


class MovePerformer
  include PieceSpecs

  def do_move(move, board)
    return do_ep_move(move, board) if move.ep

    target = board.at(move.target)

    if move.capture
      if target && target.color != move.piece.color
        board.set(move.target, move.piece)
        board.set(move.start)
        return true
      end
    else # not capture
      if target.nil?
        board.set(move.target, move.piece)
        board.set(move.start)
        return true
      end
    end

    return false
  end

  def do_ep_move(move, board)
    target_square = board.at(move.target)
    ep_pawn = board.at(move.ep_sq)

    if target_square.nil? && ep_pawn && ep_pawn.type == pawn && ep_pawn.color != move.piece.color
      board.set(move.target, move.piece)
      board.set(move.start)
      board.set(move.ep_sq)
      return true
    else
      return false
    end
  end
end
