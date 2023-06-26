require './lib/standards/piece'

class MoveArbiter

  # Take a copy of the chess board and move data which must include the target
  # square, all possible starting squares, and capture flag, then return the
  # one start square for performing the move if the move is legal. Return nil if
  # the move is illegal.
  def judge_pawn_move(board, data)
    capture = data[:capture]
    target_sq = board.at(data[:target][:f], data[:target][:r])

    if capture == false
      if target_sq.nil?
        # Square of the first pawn found on a square of all possible starting
        # squares must be returned. Otherwise, return nil to indicate no pawn
        # was found on either one or two squares.
        data[:starts].each do |square|
          if pawn? board.at(square[:f], square[:r]), data[:color]
            return square 
          end
        end

        return nil

      else # target square is not empty
        return nil
      end

    else # capture
      return nil if target_sq.nil?

      start_sq = data[:starts][0]

      if pawn? board.at(start_sq[:f], start_sq[:r]), data[:color]
        return start_sq
      end

      return nil

    end
  end

  private

  def pawn?(square, color)
    if square.nil?
      return false
    else
      return square[:piece] == Piece::PA && square[:color] == color
    end
  end
end
