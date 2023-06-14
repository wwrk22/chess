require_relative './knight_moves'
require './lib/errors/color_unknown_error'
require './lib/standards/piece'

module Move
  module Syntax
    class KnightValidator

      # Return the move if move has valid syntax. Otherwise, return nil.
      # Raise ColorUnknownError if color is unknown.
      def validate(move)
        if move[:color] != Piece::WH && move[:color] != Piece::BL
          raise ColorUnknownError.new(move[:color])
        end

        check_syntax(move)
      end

      private

      def check_syntax(move)
        KnightMoves::MOVES.each do |pattern|
          return move if move[:move] =~ pattern
        end

        nil
      end

    end
  end
end
