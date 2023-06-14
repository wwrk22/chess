require './lib/standards/pieces'

module Move
  module Syntax
    module Pawn
      WH_MOVE = /^[a-h][3-8]$/
      BL_MOVE = /^[a-h][1-6]$/


      WH_CAPTURES = [
        /^axb[3-8]$/,
        /^bx[a, c][3-8]$/,
        /^cx[b, d][3-8]$/,
        /^dx[c, e][3-8]$/,
        /^ex[d, f][3-8]$/,
        /^fx[e, g][3-8]$/,
        /^gx[f, h][3-8]$/,
        /^hxg[3-8]$/
      ]

      BL_CAPTURES = [
        /^axb[1-6]$/,
        /^bx[a, c][1-6]$/,
        /^cx[b, d][1-6]$/,
        /^dx[c, e][1-6]$/,
        /^ex[d, f][1-6]$/,
        /^fx[e, g][1-6]$/,
        /^gx[f, h][1-6]$/,
        /^hxg[1-6]$/
      ]

    end
  end
end
