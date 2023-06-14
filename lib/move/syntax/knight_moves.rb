module Move
  module Syntax
    module KnightMoves
      MOVES = [
        /^Na?x?[b,c][1-8]$/,
        /^Nb?x?[a-d^b][1-8]$/,
        /^Nc?x?[a-e^c][1-8]$/,
        /^Nd?x?[b-f^d][1-8]$/,
        /^Ne?x?[c-g^e][1-8]$/,
        /^Nf?x?[d-h^f][1-8]$/,
        /^Ng?x?[e-h^g][1-8]$/,
        /^Nh?x?[f,g][1-8]$/,
        /^N1?x?[a-h][2,3]$/,
        /^N2?x?[a-h][1-4^2]$/,
        /^N3?x?[a-h][1-5^3]$/,
        /^N4?x?[a-h][2-6^4]$/,
        /^N5?x?[a-h][3-7^5]$/,
        /^N6?x?[a-h][4-8^6]$/,
        /^N7?x?[a-h][5-8^7]$/,
        /^N8?x?[a-h][6,7]$/
      ]
    end
  end
end
