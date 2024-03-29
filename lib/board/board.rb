require './lib/standard/chess_board'
require './lib/error/invalid_square'
require_relative './board_specs'

require './lib/piece/piece_specs'
require './lib/piece/pawn'
require './lib/piece/rook'
require './lib/piece/knight'
require './lib/piece/bishop'
require './lib/piece/queen'
require './lib/piece/king'


class Board
  include BoardSpecs
  include PieceSpecs

  attr_writer :ranks
  
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
    @ranks.each_with_index do |rank, rank_idx|
      rank.each_with_index do |square, file_idx|
        if square.eql? King.new(color)
          return { file: (97 + file_idx).chr, rank: rank_idx + 1 }
        end
      end
    end

    nil
  end

  ##
  # Output a visual representation of the board to $stdout.
  def to_s
    @ranks.each_with_index.reverse_each.reduce("") do |board, (rank, rank_idx)|
      board += blank_line(rank_idx)
      board += piece_line(rank_idx, rank)

      if rank_idx == 0
        board += blank_line(rank_idx, true)
      else
        board += blank_line(rank_idx)
      end
    end
  end

  def clear
    @ranks = Array.new(8) { |_| Array.new(8, nil) }
  end

  def setup_for_game
    setup_pawn
    setup_rook
    setup_knight
    setup_bishop
    setup_queen
    setup_king
  end

  def board_copy
    @ranks.map do |rank|
      rank.map do |square|
        square
      end
    end
  end

  def setup_rook
    ['a', 'h'].each do |file|
      set({ file: file, rank: 1 }, Rook.new(white))
      set({ file: file, rank: 8 }, Rook.new(black))
    end
  end

  def setup_knight
    ['b', 'g'].each do |file|
      set({ file: file, rank: 1 }, Knight.new(white))
      set({ file: file, rank: 8 }, Knight.new(black))
    end
  end

  def setup_bishop
    ['c', 'f'].each do |file|
      set({ file: file, rank: 1 }, Bishop.new(white))
      set({ file: file, rank: 8 }, Bishop.new(black))
    end
  end

  def setup_queen
    set({ file: 'd', rank: 1 }, Queen.new(white))
    set({ file: 'd', rank: 8 }, Queen.new(black))
  end

  def setup_king
    set({ file: 'e', rank: 1 }, King.new(white))
    set({ file: 'e', rank: 8 }, King.new(black))
  end

  def setup_pawn
    files.each do |file|
      set({ file: file, rank: 2 }, Pawn.new(white))
      set({ file: file, rank: 7 }, Pawn.new(black))
    end
  end

  def piece_line(rank_idx, rank)
    (rank_idx + 1).to_s + ' ' + files.each_index.reduce("") do |line, file_idx|
      sq = square(rank_idx, file_idx)
      line += sq + mid_sq(rank, file_idx, sq) + sq
      (file_idx == files.size - 1) ? (line += "\n") : line
    end
  end

  def mid_sq(rank, file_idx, sq)
    piece = rank[file_idx]
    (piece.nil?) ? sq : piece.unicode + ' '
  end

  def blank_line(rank_idx, last_line = false)
    output = '  ' + files.each_index.reduce("") do |line, file_idx|
      sq = square(rank_idx, file_idx)
      line += sq + sq + sq
      (file_idx == files.size - 1) ? (line += "\n") : line
    end

    if last_line
      output += '    a     b     c     d     e     f     g     h'
    end

    output
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
