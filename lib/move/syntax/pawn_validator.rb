require_relative './pawn_moves'
require './lib/standards/piece'

module Move
  module Syntax
    class PawnValidator

      # Return true if move has valid syntax. Otherwise, return false.
      # Raise ColorUnknownError if color is unknown.
      def validate(move)
        return validate_capture_move(move) if move[:move].include? 'x'
        return validate_non_capture_move(move)
      end

      private

      # Validate a move that is a capture. Raise ColorUnknownError if color is
      # unknown.
      def validate_capture_move(move)
        return check_white_capture(move) if move[:color] == Piece::WH
        return check_black_capture(move) if move[:color] == Piece::BL
        raise ColorUnknownError.new(move[:color])
      end

      # Compare move string against white pawn capture-move syntax regex.
      def check_white_capture(move)
        PawnMoves::WH_CAPTURES.each do |capture|
          return move if move[:move] =~ capture
        end

        nil
      end

      # Compare move string against black pawn capture-move syntax regex.
      def check_black_capture(move)
        PawnMoves::BL_CAPTURES.each do |capture|
          return move if move[:move] =~ capture
        end

        nil
      end

      # Validate a move that is not a capture. Raise ColorUnknownError if color
      # is unknown.
      def validate_non_capture_move(move)
        return check_white_move(move) if move[:color] == Piece::WH
        return check_black_move(move) if move[:color] == Piece::BL
        raise ColorUnknownError.new(move[:color])
      end

      # Compare move string against white pawn move syntax regex.
      def check_white_move(move)
        return move if move[:move] =~ PawnMoves::WH_MOVE
      end
 
      # Compare move string against black pawn move syntax regex.
      def check_black_move(move)
        return move if move[:move] =~ PawnMoves::BL_MOVE
      end

    end
  end
end
