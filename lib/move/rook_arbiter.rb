class RookArbiter
  def judge(board, data)
    capture, starts, player_color = [data[:capture], data[:starts], data[:color]]
    target = board.at(data[:target][:f], data[:target][:r])

    return judge_capture(target, starts, player_color, board) if capture
    return judge_non_capture(target, starts, player_color, board)
  end

  # Return true if a chess piece specified by the type and color of the 'piece'
  # hash exists on the specified square of the board. Return false if the chess
  # piece does not match or if the square is empty.
  # The key-value pairs for the 'piece' hash should include the 'type' key with
  # one of the chess piece types in the Piece module, and the 'color' key with
  # either of the two chess piece colors in the Piece module.
  def check_target(board, square, piece = {})
    target = board.at(square[:file], square[:rank])

    return false if target.nil?
    target[:type] == piece[:type] && target[:color] == piece[:color]
  end

  def check_start(board, square, piece = {})
    start = board.at(square[:file], square[:rank])

    return nil if start.nil?
  end

  private

  def judge_non_capture(target, possible_starts, player_color, board)
    return nil if target.nil? == false
  end

  def judge_capture(target, possible_start, player_color, board)
  end
end
