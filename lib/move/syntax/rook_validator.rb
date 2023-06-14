require_relative './rook_moves'
require './lib/standards/piece'
require './lib/errors/color_unknown_error'

module Move
  module Syntax
    class RookValidator
 
      # Return true if move has valid syntax. Otherwise, return false.
      # Raise ColorUnknownError if color is unknown.
      def validate(move)
        if move[:color] != Piece::WH && move[:color] != Piece::BL
          raise ColorUnknownError.new(move[:color])
        end

        return validate_capture(move) if move[:move].include? 'x'
        return move if move[:move] =~ RookMoves::MOVE
      end

      private

      def validate_capture(move)
        RookMoves::CAPTURES.each do |capture|
          return move if move[:move] =~ capture
        end

        nil
      end

    end
  end
end
