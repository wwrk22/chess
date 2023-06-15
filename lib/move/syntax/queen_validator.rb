require_relative './queen_moves'
require './lib/standards/piece'
require './lib/errors/color_unknown_error'

module Move
  module Syntax
    class QueenValidator

      # Return the move if move has valid syntax. Otherwise, return nil.
      # Raise ColorUnknownError if color is unknown.
      def validate(move)
        if move[:color] != Piece::WH && move[:color] != Piece::BL
          raise ColorUnknownError.new(move[:color])
        end

        move if move[:move] =~ QueenMoves::MOVE
      end
    end
  end
end
