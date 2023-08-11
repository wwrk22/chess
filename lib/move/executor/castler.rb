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
    if castle == '0-0'
      if color == white
        white_king = board.at({ file: 'e', rank: 1 })
        white_rook = board.at({ file: 'h', rank: 1 })

        white_king_in_place = (not white_king.nil?) && (not white_king.made_first_move)
        white_rook_in_place = (not white_rook.nil?) && (not white_rook.made_first_move)

        return white_king_in_place && white_rook_in_place
      else
        black_king = board.at({ file: 'e', rank: 8 })
        black_rook = board.at({ file: 'h', rank: 8 })

        black_king_in_place = (not black_king.nil?) && (not black_king.made_first_move)
        black_rook_in_place = (not black_rook.nil?) && (not black_rook.made_first_move)

        return black_king_in_place && black_rook_in_place
      end
    else
      if color == white
        white_king = board.at({ file: 'e', rank: 1 })
        white_rook = board.at({ file: 'a', rank: 1 })

        white_king_in_place = (not white_king.nil?) && (not white_king.made_first_move)
        white_rook_in_place = (not white_rook.nil?) && (not white_rook.made_first_move)

        return white_king_in_place && white_rook_in_place
      else
      end

    end
  end

  private

  def determine_path(castle, color)
    return castle == '0-0' ?
      (color == white ? WH_K_SIDE_PATH : BL_K_SIDE_PATH) :
      (color == white ? WH_Q_SIDE_PATH : BL_Q_SIDE_PATH)
  end
end
