class MovePerformer

  ##
  # Perform the move on the board. Return true if the move was performed, or
  # false if it could not be performed.
  def do_move(move, board)
    return false if not board.at(move.target).nil?
    board.set(move.start)
    board.set(move.target, move.piece)
    true
  end

  ##
  # Perform the capture move on the board. Return true if the move was
  # performed, or false if it could not be performed.
  def do_capture(move, board)
    target = board.at(move.target)
    (target && target.color != move.piece.color) ?
      do_move(move, board) : false
  end
end
