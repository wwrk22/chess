require './lib/standard/chess_board'
require './lib/error/invalid_square'
require_relative './board_specs'


class Board
  include BoardSpecs
  
  def initialize
    @ranks = Array.new(8, Array.new(8, nil))
  end

  def at(file, rank)
    valid_file = files.include? file
    valid_rank = ranks.include? rank
    
    if valid_file && valid_rank
    else
      raise InvalidSquare::RankError.new(rank) if valid_file
      raise InvalidSquare::FileError.new(file) if valid_rank
      raise InvalidSquare::CoordinatesError.new(file, rank)
    end
  end

  def search(piece)
  end

  class << self

    def get_line(f_or_r)
      if ChessBoard::FILES.include? f_or_r.to_s
        get_file(f_or_r)
      else
        get_rank(f_or_r)
      end
    end

    # Return an array of all squares on the diagonal line through the given
    # square, going from bottom left to top right.
    def get_diagonal_a(square, line = [])
      go_bottom_left(square[:f], square[:r], line)
      go_top_right((square[:f].ord + 1).chr, square[:r] + 1, line)
      line
    end

    # Return an array of all squares on the diagonal line through the given
    # square, going from top left to bottom right.
    def get_diagonal_b(square, line = [])
      go_top_left((square[:f].ord - 1).chr, square[:r] + 1, line)
      go_bottom_right((square[:f].ord + 1).chr, square[:r] - 1, line)
      line
    end

    private

    def get_file(file)
      (1..8).reduce([]) do |line, r|
        line << { f: file, r: r }
      end
    end

    def get_rank(rank)
      ChessBoard::FILES.each_char.reduce([]) do |line, f|
        line << { f: f, r: rank }
      end
    end

    def go_bottom_left(file, rank, line)
      until rank == 0 || file.ord == 96 do
        line << { f: file, r: rank }
        file = (file.ord - 1).chr
        rank -= 1
      end
    end

    def go_top_right(file, rank, line)
      until rank == 9 || file.ord == 105 do
        line << { f: file, r: rank }
        file = (file.ord + 1).chr
        rank += 1
      end
    end

    def go_top_left(file, rank, line)
      until rank == 9 || file.ord == 96 do
        line << { f: file, r: rank }
        file = (file.ord - 1).chr
        rank += 1
      end
    end

    def go_bottom_right(file, rank, line)
      until rank == 0 || file.ord == 105 do
        line << { f: file, r: rank }
        file = (file.ord + 1).chr
        rank -= 1
      end
    end

  end # class << self
end
