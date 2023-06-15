require_relative './bishop_moves'
require './lib/errors/color_unknown_error'

module Move
  module Syntax
    class BishopValidator
      def validate(move)
        if move[:color] != Piece::WH && move[:color] != Piece::BL
          raise ColorUnknownError.new(move[:color])
        end

        move if move[:move] =~ BishopMoves::MOVE
      end
    end
  end
end