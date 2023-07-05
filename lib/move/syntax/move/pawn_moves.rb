module Move
  module Syntax
    module PawnMoves
      WH_MOVE = /^[a-h][3-8]$/
      BL_MOVE = /^[a-h][1-6]$/

      WH_CAPTURES = [
        /^axb[3-8]$/,
        /^bx(?!b)[a-c][3-8]$/,
        /^cx(?!c)[b-d][3-8]$/,
        /^dx(?!d)[c-e][3-8]$/,
        /^ex(?!e)[d-f][3-8]$/,
        /^fx(?!f)[e-g][3-8]$/,
        /^gx(?!g)[f-h][3-8]$/,
        /^hxg[3-8]$/
      ]

      BL_CAPTURES = [
        /^axb[1-6]$/,
        /^bx(?!b)[a-c][1-6]$/,
        /^cx(?!c)[b-d][1-6]$/,
        /^dx(?!d)[c-e][1-6]$/,
        /^ex(?!e)[d-f][1-6]$/,
        /^fx(?!f)[e-g][1-6]$/,
        /^gx(?!g)[f-h][1-6]$/,
        /^hxg[1-6]$/
      ]
    end
  end
end
