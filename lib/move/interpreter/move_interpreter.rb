require './lib/standards/board_standards'
require './lib/standard'

# Any move interpreted is expected to have been validated by a validator class.
class MoveInterpreter
  attr_reader :color

  # Color is required to interpret pawn moves correctly.
  def initialize(color)
    @color = color
  end

  # Parse the type of the chess piece in play.
  def parse_piece(move)
    piece = move[0]
    return Piece::PA if BoardStandards::FILES.include? piece
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

  def set_start_f_or_r(move_str, move)
    if move_str =~ /^R[a-h1-8](x|[a-h]).*$/
      f_or_r = move_str[1]
      move.start_f = f_or_r if BoardStandards::FILES.include? move_str[1]
      move.start_r = f_or_r.to_i
    end
  end
end
