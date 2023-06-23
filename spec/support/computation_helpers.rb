require './lib/standards/board_standards'

module ComputationHelpers

  def get_file(file)
    (1..8).reduce([]) do |line, rank|
      line << { f: file, r: rank }
    end
  end

  def get_rank(rank)
    BoardStandards::FILES.each_char.reduce([]) do |line, file|
      line << { f: file, r: rank }
    end
  end

end
