require './lib/board/board_specs'


class StartComputer
  include BoardSpecs

  def check_start(start_square, piece, board)
    target = board.at(start_square[:file], start_square[:rank])

    (target.nil?) ?
      false : target.type == piece.type && target.color == piece.color
  end

  ##
  # Take a moving piece, the target square, and a direction to determine
  # whether or not the piece is on the path in the direction from the target
  # square.
  def check_path(move, board, direction)
    curr_square = update_square(move.target, direction)
    check_each_square(curr_square, move, board, direction)
  end

  ##
  # [Abstract]
  # A subclass representing a kind of StartComputer should calculate how many
  # squares must be empty between the moving chess piece and the target square.
  def calculate_limit; raise "SubclassResponsibility"; end


  private

  def check_each_square(curr_square, move, board, direction)
    while valid_file?(curr_square[:file]) && valid_rank?(curr_square[:rank]) do
      piece = board.at(curr_square[:file], curr_square[:rank])
      return check_piece(piece, move.piece, curr_square) if piece
      curr_square = update_square(curr_square, direction)
    end
  end

  def check_piece(piece, moving_piece, curr_square)
    return curr_square if piece.eql? moving_piece
  end

  def update_square(square, direction)
    file_ord = square[:file].ord + direction[:file]
    { file: file_ord.chr, rank: square[:rank] + direction[:rank] }
  end
end
