class StartComputer
  def check_start(move, board)
    target_file, target_rank = [move.target[:file], move.target[:rank]]
    target = board.at(target_file, target_rank)

    return false if target.nil?

    target.type == move.piece && target.color == move.color
  end
end
