module BoardSpecs
  FILES = ('a'..'h').to_a
  RANKS = (1..8).to_a
  WHITE_SQUARE = "\u2B1C"
  BLACK_SQUARE = "\u2B1B"

  private_constant :FILES, :RANKS, :WHITE_SQUARE, :BLACK_SQUARE

  def to_rank_index(rank)
    rank - 1
  end

  def to_file_index(file)
    file.ord - 97
  end

  def files
    FILES
  end

  def ranks
    RANKS
  end

  def white_square
    WHITE_SQUARE
  end

  def black_square
    BLACK_SQUARE
  end

  def valid_file?(file)
    FILES.include? file
  end

  def valid_rank?(rank)
    RANKS.include? rank
  end

  def valid_square?(square)
    valid_file?(square[:file]) && valid_rank?(square[:rank])
  end

  def compute_sq(sq, dir)
    { file: (sq[:file].ord + dir[:file].ord).chr,
      rank: sq[:rank] + dir[:rank] }
  end
end
