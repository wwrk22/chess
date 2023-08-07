module MoveSyntax
  module King
    MOVE = /^Kx?[a-h][1-8]$/
    CASTLE = /^0-0(-0)?$/

    def king_move_syntax
      MOVE
    end

    def king_castle_syntax
      CASTLE
    end
  end
end
