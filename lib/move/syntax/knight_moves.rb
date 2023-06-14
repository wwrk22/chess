module Move
  module Syntax
    module KnightMoves
      MOVE = /^N([a-h1-8])?[a-h^\1][1-8^\1]$/
      CAPTURES = /^N([a-h1-8])?x[a-h^\1][1-8^\1]$/
    end
  end
end
