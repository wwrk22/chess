class StartComputer
  def check_start(start_square, piece, board)
    target = board.at(start_square[:file], start_square[:rank])

    (target.nil?) ?
      false : target.type == piece.type && target.color == piece.color
  end
end
