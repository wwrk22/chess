require './lib/board/board_specs'
require './lib/move/syntax/pattern/general'
require './lib/piece/piece_specs'


# Any move interpreted is expected to have been validated by a validator class.
class MoveInterpreter
  include BoardSpecs
  include MoveSyntax::General
  include PieceSpecs

  # Parse the destination square of the move.
  def parse_target(move_str)
    target_file, target_rank = [move_str[-2], move_str[-1].to_i]

    if move_str[-1] =~ /#{check}|#{checkmate}/
      target_file, target_rank = [move_str[-3], move_str[-2].to_i]
    end

    { file: target_file, rank: target_rank }
  end

  # Determine whether or not the move is a capture.
  def capture?(move_str)
    capture_mark = (move_str[-1] =~ /#{check}|#{checkmate}/) ?
      move_str[-4] : move_str[-3]

    capture_mark == capture
  end

  # Parse then return the file or rank of the square of the moving piece.
  # A king move is not handled since there is no start coordinate for it.
  def parse_start_coordinate(move)
    if move.piece.type == pawn
      return pawn_start_coordinate(move)
    else # Not pawn and king
      return non_pawn_start_coordinate(move)
    end
  end


  private

  def pawn_start_coordinate(move)
    if move.capture
      coordinate = move.str[0]
      return valid_file?(coordinate) ? coordinate : coordinate.to_i
    end
  end

  def non_pawn_start_coordinate(move)
    if move.str =~ /^[RNBQ][a-h1-8]x?[a-h][1-8]$/
      coordinate = move.str[1]
      return valid_file?(coordinate) ? coordinate : coordinate.to_i
    end
  end
end
