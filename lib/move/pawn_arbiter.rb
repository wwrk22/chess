require './lib/standards/piece'

class PawnArbiter

  # Take a copy of the chess board and move data which must include the target
  # square, all possible starting squares, and capture flag, then return the
  # one start square for performing the move if the move is legal. Return nil if
  # the move is illegal.
  def judge(board, data)
    capture, starts, player_color = [data[:capture], data[:starts], data[:color]]
    target = board.at(data[:target][:f], data[:target][:r])

    return judge_non_capture(target, starts, player_color, board) if capture == false
    return judge_capture(starts[0], target, board, player_color)
  end

  private

  def judge_capture(start, target, board, player_color)
    return nil if target.nil? || target[:color] == player_color
    return start if square_holds_pawn(start, board, player_color)
    nil
  end

  # Square of the first pawn found on a square of all possible starting squares
  # must be returned. Otherwise, return nil to indicate no pawn was found on
  # either one or two squares.
  def judge_non_capture(target_square, possible_starts, player_color, board)
    return nil if target_square.nil? == false

    possible_starts.each do |square|
      return square if square_holds_pawn(square, board, player_color)
    end

    nil
  end

  def square_holds_pawn(square, board, player_color)
    chess_piece = board.at(square[:f], square[:r])
    return false if chess_piece.nil? # square does not hold a chess piece
    chess_piece[:piece] == Piece::PA && chess_piece[:color] == player_color
  end
end
