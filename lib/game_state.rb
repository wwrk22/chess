require './lib/piece/piece_specs'


class GameState
  include PieceSpecs

  def game_winner(board)
    wh_king_found = board.search_king(white)
    bl_king_found = board.search_king(black)

    return nil if (not wh_king_found) && (not bl_king_found)
    return white if wh_king_found && (not bl_king_found)
    return black if bl_king_found && (not wh_king_found)
  end
end
