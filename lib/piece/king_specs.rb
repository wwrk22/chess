module KingSpecs
  DIRECTIONS = [{ file: 0, rank: 1 }, { file: 1, rank: 1 },
                { file: 1, rank: 0 }, { file: 1, rank: -1 },
                { file: 0, rank: -1 }, { file: -1, rank: -1 },
                { file: -1, rank: 0 }, { file: -1, rank: 1 }]

  def king_dirs
    DIRECTIONS
  end
end
