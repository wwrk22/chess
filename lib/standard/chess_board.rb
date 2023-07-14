module ChessBoard
  FILES = 'abcdefgh'
  RANKS = (0..8)

  def valid_file?(file)
    file.is_a?(String) && FILES.include?(file)
  end

  def valid_rank?(rank)
    rank.is_a?(Integer) && RANKS.include?(rank)
  end
end
