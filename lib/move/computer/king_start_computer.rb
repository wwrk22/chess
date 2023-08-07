require './lib/board/board_specs'
require './lib/piece/king_specs'


class KingStartComputer
  include KingSpecs
  include BoardSpecs

  ##
  # Return an array of the possible valid starting squares for a king move.
  def all_possible_start_sqs(target_sq)
    king_dirs.reduce([]) do |start_sqs, dir|
      sq = compute_sq(target_sq, dir)
      start_sqs << sq if valid_square? sq
      start_sqs
    end
  end

  ##
  # Prune an array of squares to find the one potentially existing square that
  # holds the king.
  def find_king(king, start_sqs, board)
    filtered = start_sqs.filter do |sq|
      board.at(sq).eql? king
    end

    (filtered.empty?) ? nil : filtered[0]
  end

  def compute_start(move, board)
    start_sqs = all_possible_start_sqs(move.target)
    find_king(move.piece, start_sqs, board)
  end
end
