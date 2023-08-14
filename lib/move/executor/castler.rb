require './lib/piece/piece_specs'


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

  ##
  # For the given castling move, check if the path between the king and the
  # rook is clear. Return true if all squares are empty, and false if any are
  # not.
  def clear_path?(castle, color, board)
    determine_path(castle, color).all? do |square|
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

  private

  def not_moved_yet?(piece)
    (not piece.nil?) && (not piece.made_first_move)
  end

  def determine_path(castle, color)
    return castle == '0-0' ?
      (color == white ? WH_K_SIDE_PATH : BL_K_SIDE_PATH) :
      (color == white ? WH_Q_SIDE_PATH : BL_Q_SIDE_PATH)
  end
end
