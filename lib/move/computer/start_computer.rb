require './lib/board/board_specs'
require './lib/piece/piece_specs'


class StartComputer
  include BoardSpecs
  include PieceSpecs

  def check_start(start_square, piece, board)
    target = board.at(start_square[:file], start_square[:rank])
    target.eql? piece
  end

  ##
  # Take a moving piece, the target square, and a direction to determine
  # whether or not the piece is on the path in the direction from the target
  # square.
  def check_path(move, board, direction, start_square = nil)
    curr_square = update_square(move.target, direction)
    check_each_square(curr_square, move, board, direction, start_square)
  end

  def check_multiple_paths(move, board, directions)
    result = directions.reduce([]) do |squares, direction|
      squares << check_path(move, board, direction)
    end

    starting_squares = result.filter { |square| square }
    return starting_squares[0] if starting_squares.length == 1
  end

  def valid_start?(move, board, start_square)
    piece = board.at(start_square[:file], start_square[:rank])

    if piece.eql? move.piece
      file_step = start_square[:file].ord - move.target[:file].ord
      rank_step = start_square[:rank] - move.target[:rank]
      file_step = (file_step > 0) ? (1) : ((file_step < 0) ? -1 : 0)
      rank_step = (rank_step > 0) ? (1) : ((rank_step < 0) ? -1 : 0)
      direction = { file: file_step, rank: rank_step }
      return check_path(move, board, direction, start_square)
    else
      return nil
    end
  end

  ##
  # [Abstract]
  # A subclass representing a kind of StartComputer should calculate how many
  # squares must be empty between the moving chess piece and the target square.
  def compute_start; raise "SubclassResponsibility"; end

  ##
  # [Abstract]
  # A subclass representing a kind of StartComputer should calculate how many
  # squares must be empty between the moving chess piece and the target square.
  def calculate_limit; raise "SubclassResponsibility"; end

  private

  def check_each_square(curr_square, move, board, direction, start_square)
    while valid_file?(curr_square[:file]) && valid_rank?(curr_square[:rank]) &&
          curr_square != start_square do
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
