require './lib/piece/piece_specs'
require './lib/board/board'


class MovePerformer
  include PieceSpecs

  def do_move(move, board)
    return do_ep_move(move, board) if move.ep

    target = board.at(move.target)

    return false if (not move.capture) && target
    return false if move.capture && (not opponent_piece? target, move.piece.color)
    update_board(move, board)
  end

  def do_ep_move(move, board)
    target = board.at(move.target)
    ep_pawn = board.at(move.ep_sq)

    return  ep_move?(target, ep_pawn, move.piece) ?
      update_board(move, board) : false
  end


  private

  def ep_move?(target, ep_pawn, moving_pawn)
    target.nil? &&
    ep_pawn &&
    ep_pawn.type == pawn &&
    ep_pawn.color != moving_pawn.color
  end

  def update_board(move, board)
    board.set(move.target, move.piece)
    board.set(move.start)
    board.set(move.ep_sq) if move.ep
    true
  end

  def opponent_piece?(piece, player_color)
    piece && piece.color != player_color
  end
end
