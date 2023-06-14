module Move
  module Syntax
    module RookMoves
      MOVE = /^R[a-h][1-8]$/
      CAPTURES = [/^Rx[a-h][1-8]$/, /^R[a-h, 1-8]x[a-h][1-8]$/]
    end
  end
end
