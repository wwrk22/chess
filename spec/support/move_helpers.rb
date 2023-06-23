require './lib/standards/piece'

module MoveHelpers
  # Create and return a Move object with attributes required for a non-capture
  # pawn move.
  def pawn_move(move = Move.new)
    move.target = 'a3'
    move.color = Piece::WH
    move
  end

  # Create and return a move object with attributes required for a pawn capture.
  def pawn_capture(move = Move.new)
    pawn_move(move)
    move.start_f = 'b'
    move
  end
end
