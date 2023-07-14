module BoardComputer
  
  def compute_direction(a, b)
    file_diff = b[:file].ord - a[:file].ord
    rank_diff = b[:rank] - a[:rank]
    { file: file_diff, rank: rank_diff }
  end
end
