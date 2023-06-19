require './lib/standards/board'
require './lib/standard'

# Any move interpreted is expected to have been validated by a validator class.
class MoveInterpreter
  attr_reader :color

  def initialize(color)
    @color = color
  end

  # Parse the type of the chess piece in play.
  def parse_piece(move)
    piece = move[0]
    return Piece::PA if Board::FILES.include? piece
    return piece
  end

  # Parse the destination square of the move.
  def parse_target(move)
    if move.end_with?(Standard::CH) || move.end_with?(Standard::CM)
      { f: move[-3], r: move[-2].to_i }
    else
      { f: move[-2], r: move[-1].to_i }
    end
  end

  # Determine whether or not the move is a capture.
  def capture?(move)
    if move.end_with?(Standard::CH) || move.end_with?(Standard::CM)
      return (move[-4] == Standard::CAPTURE) ? true : false
    else
      return (move[-3] == Standard::CAPTURE) ? true : false
    end
  end
end
