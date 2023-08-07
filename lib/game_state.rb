require './lib/piece/piece_specs'


class GameState
  include PieceSpecs

  ##
  # Search for both white and black kings on the board and return 0 or 1 to
  # indicate not-found or found for each.
  # Return value format e.g.: { wh_king_found: 0, bl_king_found: 1 }
  def search_kings(board)
    wh_king = { type: king, color: white }
    bl_king = { type: king, color: black }
    return { wh_king_found: board.search_king(white),
             bl_king_found: board.search_king(black) }
  end

  ##
  # Tell the winner of a game based on the white or black king found.
  # If both are found, then return nil. Otherwise, return 'wh' or 'bl'
  # for white only or black only respectively.
  def determine_winner(wh_king_found, bl_king_found)
    return nil if wh_king_found - bl_king_found == 0
    return white if wh_king_found - bl_king_found == 1
    return black if bl_king_found - wh_king_found == 1
  end
end
