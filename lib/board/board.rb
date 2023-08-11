require './lib/standard/chess_board'
require './lib/error/invalid_square'
require './lib/piece/piece_specs'
require_relative './board_specs'


class Board
  include BoardSpecs
  include PieceSpecs
  
  def initialize
    clear
  end

  ##
  # Return the ChessPiece found on the given square on the board. An empty
  # square returns nil.
  def at(sq)
    check_coordinates_error(sq) if not valid_square? sq
    rank_idx = to_rank_index(sq[:rank])
    file_idx = to_file_index(sq[:file])
    return @ranks[rank_idx][file_idx]
  end

  def set(sq, piece = nil)
    rank_index = to_rank_index(sq[:rank])
    file_index = to_file_index(sq[:file])

    @ranks[rank_index][file_index] = piece
  end

  def search_king(color)
    @ranks.each do |rank|
      return true if rank.one? { |sq| sq.eql? ChessPiece.new(king, color) }
    end

    false
  end

  ##
  # Output a visual representation of the board to $stdout.
  def to_s
    @ranks.each_with_index.reverse_each.reduce("") do |board, (rank, rank_idx)|
      board += blank_line(rank_idx)
      board += piece_line(rank_idx, rank)
      board += blank_line(rank_idx)
    end
  end

  def clear
    @ranks = Array.new(8) { |_| Array.new(8, nil) }
  end


  private

  def piece_line(rank_idx, rank)
    files.each_index.reduce("") do |line, file_idx|
      sq = square(rank_idx, file_idx)
      line += sq + mid_sq(rank, file_idx, sq) + sq
      (file_idx == files.size - 1) ? (line += "\n") : line
    end
  end

  def mid_sq(rank, file_idx, sq)
    piece = rank[file_idx]
    (piece.nil?) ? sq : piece.unicode + ' '
  end

  def blank_line(rank_idx)
    files.each_index.reduce("") do |line, file_idx|
      sq = square(rank_idx, file_idx)
      line += sq + sq + sq
      (file_idx == files.size - 1) ? (line += "\n") : line
    end
  end

  def square(rank_idx, file_idx)
    sum = rank_idx + file_idx
    (sum % 2 == 0) ? black_square : white_square
  end

  def check_coordinates_error(square)
    file, rank = [square[:file], square[:rank]]
    raise InvalidSquare::RankError.new(rank) if files.include?(file)
    raise InvalidSquare::FileError.new(file) if ranks.include?(rank)
    raise InvalidSquare::CoordinatesError.new(file, rank)
  end
end
