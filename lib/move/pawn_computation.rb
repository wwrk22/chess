require './lib/standards/piece'

# Contains the lambda that performs a computation to determine possible
# starting squares for a pawn move. This module is to be used for the
# Move#compute method.
# All data given by a Move object is expected to have been validated by a
# validator class.
module PawnComputation

  MOVE = ->(data) do
    if data[:color] == Piece::WH
      return Helpers.white_move(data[:target][:f], data[:target][:r])
    else
      return Helpers.black_move(data[:target][:f], data[:target][:r])
    end
  end

  CAPTURE = ->(data) do
    if data[:color] == Piece::WH
      return [{ f: data[:start_f], r: data[:target][:r] - 1 }]
    else
      return [{ f: data[:start_f], r: data[:target][:r] + 1 }]
    end
  end

  private 
  
  module Helpers
    class << self
      def white_move(file, rank)
        start_squares = []
        start_squares << { f: file, r: rank - 1 }
        start_squares << { f: file, r: rank - 2 } if rank == 4
        start_squares
      end
      
      def black_move(file, rank)
        start_squares = []
        start_squares << { f: file, r: rank + 1 }
        start_squares << { f: file, r: rank + 2 } if rank == 5
        start_squares
      end
    end
  end
end
