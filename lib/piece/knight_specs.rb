module KnightSpecs
  DIRECTIONS = [{ file: 1, rank: 2 }, { file: 2, rank: 1 },
                { file: 2, rank: -1 }, { file: 1, rank: -2 },
                { file: -1, rank: -2 }, { file: -2, rank: -1 },
                { file: -2, rank: 1 }, { file: -1, rank: 2 }]

  def dir
    DIRECTIONS
  end
end
