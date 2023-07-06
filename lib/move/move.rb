class ChessMove
  # The starting and ending squares.
  # Format e.g.: { file: 'a', rank: 3 }
  attr_accessor :start, :target

  # The type and color of the moving piece.
  # Format e.g.: { type: ChessPiece::PA, color: ChessPiece::WH }
  attr_accessor :moving_piece

  # Indicate whether or not the move is a capture.
  # Format: Boolean
  attr_accessor :capture

  # The direction in which the moving piece moves to get to its target.
  # Format e.g.: { file: 1, rank: 0 } indicates a horizontal path
  attr_accessor :direction
end
