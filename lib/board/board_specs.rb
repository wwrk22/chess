module BoardSpecs
  FILES = ('a'..'h').to_a
  RANKS = (1..8).to_a
  private_constant :FILES, :RANKS

  def files
    return FILES
  end

  def ranks
    return RANKS
  end
end
