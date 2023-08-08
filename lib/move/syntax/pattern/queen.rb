module MoveSyntax
  module Queen
    MOVE = /^Q[a-h1-8]?x?[a-h][1-8][+#]?$/

    def queen_move_syntax
      MOVE
    end
  end
end
