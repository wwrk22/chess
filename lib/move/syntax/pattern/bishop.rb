module MoveSyntax
  module Bishop
    MOVE = /^B([a-h1-8])?x?(?!\1)[a-h](?!\1)[1-8][+#]?$/

    def bishop_move_syntax
      MOVE
    end
  end
end
