module Move
  module Syntax
    module KnightMoves
      MOVES = [
        /^Nx?[a-h][1-8]$/,
        /^Nax?[b,c][1-8]$/,
        /^Nbx?(?!b)[a-d][1-8]$/,
        /^Ncx?(?!c)[a-e][1-8]$/,
        /^Ndx?(?!d)[b-f][1-8]$/,
        /^Nex?(?!e)[c-g][1-8]$/,
        /^Nfx?(?!f)[d-h][1-8]$/,
        /^Ngx?(?!g)[e-h][1-8]$/,
        /^Nhx?[f,g][1-8]$/,
        /^N1x?[a-h][2-3]$/,
        /^N2x?[a-h](?!2)[1-4]$/,
        /^N3x?[a-h](?!3)[1-5]$/,
        /^N4x?[a-h](?!4)[2-6]$/,
        /^N5x?[a-h](?!5)[3-7]$/,
        /^N6x?[a-h](?!6)[4-8]$/,
        /^N7x?[a-h](?!7)[5-8]$/,
        /^N8x?[a-h][6-7]$/
      ]
    end
  end
end