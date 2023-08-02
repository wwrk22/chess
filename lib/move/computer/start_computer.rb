class StartComputer
  ##
  # [Abstract]
  # A subclass representing a kind of StartComputer should calculate how many
  # squares must be empty between the moving chess piece and the target square.
  def calculate_limit; raise "SubclassResponsibility"; end

  def check_start(start_square, piece, board)
    target = board.at(start_square[:file], start_square[:rank])

    (target.nil?) ?
      false : target.type == piece.type && target.color == piece.color
  end
end
