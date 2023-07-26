require './lib/standard/chess_piece'


class GameState
  ##
  # Search for both white and black kings on the board and return 0 or 1 to
  # indicate not-found or found for each.
  # Return value format e.g.: { wh_king_found: 0, bl_king_found: 1 }
  def search_kings(board)
    wh_king = { type: ChessPiece::KI, color: ChessPiece::WH }
    bl_king = { type: ChessPiece::KI, color: ChessPiece::BL }
    return { wh_king_found: board.search(wh_king),
             bl_king_found: board.search(bl_king) }
  end

  ##
  # Tell the winner of a game based on the white or black king found.
  # If both are found, then return nil. Otherwise, return 'wh' or 'bl'
  # for white only or black only respectively.
  def determine_winner(wh_king_found, bl_king_found)
    return nil if wh_king_found - bl_king_found == 0
    return ChessPiece::WH if wh_king_found - bl_king_found == 1
    return ChessPiece::BL if bl_king_found - wh_king_found == 1
  end
end
