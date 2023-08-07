module MoveSyntax
  module Rook
    MOVE = /^R[a-h1-8]?x?[a-h][1-8]$/

    def rook_move_syntax
      MOVE
    end
  end
end
