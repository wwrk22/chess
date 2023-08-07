module MoveSyntax
  module Pawn
    WH_MOVE = /^(([a-h])x)?(?!\2)[a-h][3-8]$/
    BL_MOVE = /^(([a-h])x)?(?!\2)[a-h][1-6]$/

    def wh_pawn_move_syntax
      WH_MOVE
    end

    def bl_pawn_move_syntax
      BL_MOVE
    end
  end
end
