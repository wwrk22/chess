module BoardComputer
  def compute_direction(a, b)
    file_diff = b[:file].ord - a[:file].ord
    rank_diff = b[:rank] - a[:rank]

    if file_diff == 0 || rank_diff == 0 || file_diff.abs == rank_diff.abs
      return { file: file_diff, rank: rank_diff }
    end
  end
end
