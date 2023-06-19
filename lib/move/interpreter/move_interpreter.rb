require './lib/standards/board'

# Any move interpreted is expected to have been validated by a validator class.
class MoveInterpreter
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def parse_piece(move)
    piece = move[0]
    return Piece::PA if Board::FILES.include? piece
    return piece
  end

end
