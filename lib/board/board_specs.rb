module BoardSpecs
  FILES = ('a'..'h').to_a
  RANKS = (1..8).to_a
  WHITE_SQUARE = "\u2B1C"
  BLACK_SQUARE = "\u2B1B"
  private_constant :FILES, :RANKS, :WHITE_SQUARE, :BLACK_SQUARE

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
end
