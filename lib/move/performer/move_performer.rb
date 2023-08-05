class MovePerformer
  def do_move(move, board)
    return false if board.at_sq(move.target).nil? == false

    board.set(move.start)
    board.set(move.target, move.piece)
    true
  end
end
