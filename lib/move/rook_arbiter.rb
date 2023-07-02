class RookArbiter
  def judge(board, data)
    capture, starts, player_color = [data[:capture], data[:starts], data[:color]]
    target = board.at(data[:target][:f], data[:target][:r])

    return judge_capture(target, starts, player_color, board) if capture
    return judge_non_capture(target, starts, player_color, board)
  end

  private

  def judge_non_capture(target, possible_starts, player_color, board)
    return nil if target.nil? == false

  end

  def judge_capture(target, possible_start, player_color, board)
  end
end
