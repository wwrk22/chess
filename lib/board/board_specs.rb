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
end
