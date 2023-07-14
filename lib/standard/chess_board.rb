module ChessBoard
  FILES = 'abcdefgh'
  RANKS = (0..8)

  def valid_file?(file)
    FILES.include? file
  end

  def valid_rank?(rank)
    RANKS.include? rank
  end
end
