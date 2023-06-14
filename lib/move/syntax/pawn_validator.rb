require_relative './pawn_moves'
require './lib/standards/piece'

module Move
  module Syntax
    class PawnValidator
      # Return true if move has valid syntax. Otherwise, return false.
      def validate(move)
        return validate_capture_move(move) if move[:move].include? 'x'
        return validate_non_capture_move(move)
      end

      private

      # Validate a move that is a capture. Raise error if color is unknown.
      def validte_capture_move(move)
      end

      # Validate a move that is NOT a capture. Raise error if color is unknown.
      def validate_non_capture_move(move)
        return check_white_move(move) if move[:color] == Piece::WH
        return check_black_move(move) if move[:color] == Piece::BL
        raise StandardError
        #raise ColorUnknownError
      end

      def check_white_move(move)
        return move[:move] =~ PawnMoves::WH_MOVE ? move : nil
      end

      def check_black_move(move)
        return move[:move] =~ PawnMoves::BL_MOVE ? move : nil
      end
    end
  end
end
