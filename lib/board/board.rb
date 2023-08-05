require './lib/standard/chess_board'
require './lib/error/invalid_square'
require_relative './board_specs'


class Board
  include BoardSpecs
  
  def initialize
    @ranks = Array.new(8, Array.new(8, nil))
  end

  ##
  # Return the ChessPiece found on the given square. An empty square returns
  # nil.
  def at(square)
    at(square[:file], square[:rank])
  end

  ##
  # Return the ChessPiece found on the square designated by the given
  # coordinates. An empty square returns nil.
  def at(file, rank)
    check_coordinates(file, rank)

    file_index = files.index(file)
    @ranks[rank][file_index]
  end

  def search(piece)
  end

  ##
  # Output a visual representation of the board to $stdout.
  def to_s
    @ranks.each_with_index.reduce("") do |board, (rank, rank_index)|
      rank.each_with_index.reduce(board) do |line, (square, file_index)|
        board += format_square_or_piece(square, file_index, rank_index)
      end
    end
  end

  ##
  # Format the given square for printing. Return the unicode string of the
  # formatted square.
  def format_square(square, file_index, rank_index)
    formatted = black_square
    formatted = white_square if (file_index % 2) + (rank_index % 2) == 1
    formatted += "\n" if file_index == 7
    formatted
  end

  ##
  # Format the given piece for printing. Return the unicode string of the
  # formatted piece.
  def format_piece(piece, file_index, rank_index)
    file_index == 7 ? (piece.unicode + "\n") : piece.unicode
  end


  private

  def format_square_or_piece(square, file_index, rank_index)
    if square.nil?
      return format_square(square, file_index, rank_index)
    else
      return format_piece(square, file_index, rank_index)
    end
  end

  def check_coordinates(file, rank)
    return if files.include?(file) && ranks.include?(rank)
    raise InvalidSquare::RankError.new(rank) if files.include?(file)
    raise InvalidSquare::FileError.new(file) if ranks.include?(rank)
    raise InvalidSquare::CoordinatesError.new(file, rank)
  end
end
