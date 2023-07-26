require './lib/standard/chess_board'
require './lib/standard/standard'
require './lib/standard/chess_piece'


# Any move interpreted is expected to have been validated by a validator class.
class MoveInterpreter
  attr_reader :color

  # Color is required to interpret pawn moves correctly.
  def initialize(color)
    @color = color
  end

  # Parse the destination square of the move.
  def parse_target(move)
    target_file, target_rank = [move[-2], move[-1].to_i]

    if move.end_with?(Standard::CH) || move.end_with?(Standard::CM)
      target_file, target_rank = [move[-3], move[-2].to_i]
    end

    { file: target_file, rank: target_rank }
  end

  # Determine whether or not the move is a capture.
  def capture?(move)
    capture_mark = move[-3]

    if move.end_with?(Standard::CH) || move.end_with?(Standard::CM)
      capture_mark = move[-4]
    end

    capture_mark == Standard::CAPTURE
  end

  # Parse then return the file or rank of the square of the moving piece.
  def parse_starting_square(move)
    # Move is for pawn.
    return { file: move[0] } if move =~ /^[a-h]x[a-h][1-8]$/

    # Move is for rook, knight, bishop, or queen.
    ChessBoard::FILES.include?(move[1]) ? { file: move[1] } : { rank: move[1].to_i }
  end
end
