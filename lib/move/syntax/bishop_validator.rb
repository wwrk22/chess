require_relative './bishop_moves'

module Move
  module Syntax
    class BishopValidator
      def validate(move)
        move if move[:move] =~ BishopMoves::MOVE
      end
    end
  end
end
