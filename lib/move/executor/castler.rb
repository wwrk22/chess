require './lib/piece/piece_specs'

require './lib/move/move'

require './lib/move/computer/pawn_start_computer'
require './lib/move/computer/rook_start_computer'
require './lib/move/computer/knight_start_computer'
require './lib/move/computer/bishop_start_computer'
require './lib/move/computer/king_start_computer'
require './lib/move/computer/queen_start_computer'


class Castler
  include PieceSpecs
  
  WH_K_SIDE_PATH = ['f', 'g'].map { |file| { file: file, rank:  1 } }
  WH_Q_SIDE_PATH = ['b', 'c', 'd'].map { |file| { file: file, rank: 1 } }

  BL_K_SIDE_PATH = ['f', 'g'].map { |file| { file: file, rank: 8 } }
  BL_Q_SIDE_PATH = ['b', 'c', 'd'].map { |file| { file: file, rank: 8 } }

  WH_K_SIDE_CHECK_SQS = ['e', 'f', 'g'].map { |file| { file: file, rank: 1 } }
  WH_Q_SIDE_CHECK_SQS = ['e', 'd', 'c'].map { |file| { file: file, rank: 1 } }

  BL_K_SIDE_CHECK_SQS = ['e', 'f', 'g'].map { |file| { file: file, rank: 8 } }
  BL_Q_SIDE_CHECK_SQS = ['e', 'd', 'c'].map { |file| { file: file, rank: 8 } }

  def initialize
    @pawn_computer = PawnStartComputer.new
    @rook_computer = RookStartComputer.new
    @knight_computer = KnightStartComputer.new
    @bishop_computer = BishopStartComputer.new
    @queen_computer = QueenStartComputer.new
    @king_computer = KingStartComputer.new
  end

  ##
  # Perform a castling move if all criteria are satisfied.
  def do_castle(move, color, board)
    a = pieces_in_place?(move.str, color, board)
    b = clear_path?(move.str, color, board)
    c = checked_path?(move.str, color, board)

    if a && b && (not c)
      rank = (color == white) ? 1 : 8
      move_king = board.at({ file: 'e', rank: rank })
      move_rook = board.at({ file: 'h', rank: rank })

      if move.str == '0-0'
        castle_kingside(rank, move_rook, move_king, board)
      else
        castle_queenside(rank, move_rook, move_king, board)
      end

      return true
    end

    false
  end

  ##
  # For the given castling move, check if the path between the king and the
  # rook is clear. Return true if all squares are empty, and false if any are
  # not.
  def clear_path?(castle, color, board)
    king_path(castle, color).all? do |square|
      board.at(square).nil?
    end
  end

  ##
  # For the given castling move, check if the right king and the rook have not
  # moved yet. Return true if so, or false otherwise.
  def pieces_in_place?(castle, color, board) 
    rank = (color == white) ? 1 : 8
    rook_file = (castle == '0-0') ? 'h' : 'a'

    move_king = board.at({ file: 'e', rank: rank })
    move_rook = board.at({ file: rook_file, rank: rank })

    return not_moved_yet?(move_king) && not_moved_yet?(move_rook)
  end

  ##
  # Check a path of castling squares to see if a king on that square draws a
  # check.
  def checked_path?(castle, color, board)
    path = king_path(castle, color, true)

    # Use the different start computers to see if there are ANY start squares
    # successfully computed for the target square that is the square on the
    # king's path in castling.
    path.any? { |square| checked?(square, color, board) }
  end

  private

  def castle_queenside(rank, move_rook, move_king, board)
    board.set({ file: 'd', rank: rank }, move_rook)
    board.set({ file: 'a', rank: rank })

    board.set({ file: 'c', rank: rank }, move_king)
    board.set({ file: 'e', rank: rank })
  end

  def castle_kingside(rank, move_rook, move_king, board)
    board.set({ file: 'f', rank: rank }, move_rook)
    board.set({ file: 'h', rank: rank })

    board.set({ file: 'g', rank: rank }, move_king)
    board.set({ file: 'e', rank: rank })
  end

  def checked?(square, color, board)
    checked_by_pawn?(square, color, board) ||
    checked_by_knight?(square, color, board) ||
    checked_by_rook?(square, color, board) ||
    checked_by_bishop?(square, color, board) ||
    checked_by_queen?(square, color, board) ||
    checked_by_king?(square, color, board)
  end

  def checked_by_king?(square, color, board)
    opp_color = (color == white) ? black : white

    move = Move.new(king + 'x' + square[:file] + square[:rank].to_s, opp_color, true)
    move.piece = King.new(opp_color)
    move.target = square

    not @king_computer.compute_start(move, board).nil?
  end

  def checked_by_queen?(square, color, board)
    opp_color = (color == white) ? black : white

    move = Move.new(queen + 'x' + square[:file] + square[:rank].to_s, opp_color, true)
    move.piece = Queen.new(opp_color)
    move.target = square

    not @queen_computer.compute_start(move, board).nil?
  end

  def checked_by_bishop?(square, color, board)
    opp_color = (color == white) ? black : white

    move = Move.new(bishop + 'x' + square[:file] + square[:rank].to_s, opp_color, true)
    move.piece = Bishop.new(opp_color)
    move.target = square

    not @bishop_computer.compute_start(move, board).nil?
  end

  def checked_by_rook?(square, color, board)
    opp_color = (color == white) ? black : white

    move = Move.new(rook + 'x' + square[:file] + square[:rank].to_s, opp_color, true)
    move.piece = Rook.new(opp_color)
    move.target = square

    not @rook_computer.compute_start(move, board).nil?
  end

  def checked_by_knight?(square, color, board)
    opp_color = (color == white) ? black : white

    move = Move.new(knight + 'x' + square[:file] + square[:rank].to_s, opp_color, true)
    move.piece = Knight.new(opp_color)
    move.target = square

    not @knight_computer.compute_start(move, board).nil?
  end

  def checked_by_pawn?(square, color, board)
    left_file = (square[:file].ord - 1).chr
    right_file = (square[:file].ord + 1).chr
    rank_diff = (color == white) ? 1 : -1
    opp_color = (color == white) ? black : white

    left_move = Move.new(left_file + 'x' + square[:file] + square[:rank].to_s, opp_color, true)
    left_move.start_coordinate = left_file
    left_move.piece = board.at({ file: left_move.start_coordinate, rank: square[:rank] + rank_diff })
    left_move.target = { file: square[:file], rank: square[:rank] }

    right_move = Move.new(right_file + 'x' + square[:file] + square[:rank].to_s, opp_color, true)
    right_move.start_coordinate = right_file
    right_move.piece = board.at({ file: right_move.start_coordinate, rank: square[:rank] + rank_diff })
    right_move.target = square

    not (@pawn_computer.compute_start(left_move, board).nil? &&
         @pawn_computer.compute_start(right_move, board).nil?)
  end

  def not_moved_yet?(piece)
    (not piece.nil?) && (not piece.made_first_move)
  end

  def king_path(castle, color, include_start = false)
    if include_start
      return castle == '0-0' ?
        (color == white ? WH_K_SIDE_CHECK_SQS : BL_K_SIDE_CHECK_SQS) :
        (color == white ? WH_Q_SIDE_CHECK_SQS : BL_Q_SIDE_CHECK_SQS)
    else
      return castle == '0-0' ?
        (color == white ? WH_K_SIDE_PATH : BL_K_SIDE_PATH) :
        (color == white ? WH_Q_SIDE_PATH : BL_Q_SIDE_PATH)
    end
  end
end
