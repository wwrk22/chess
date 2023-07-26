module InvalidSquare
  class FileError < StandardError
    def initialize(file)
      msg = "The file #{file} is invalid. Valid range is a-h."
      super(msg)
    end
  end

  class RankError < StandardError
    def initialize(rank)
      msg = "The rank #{rank} is invalid. Valid range is 0-7."
      super(msg)
    end
  end

  class CoordinatesError < StandardError
    def initialize(file, rank)
      msg = "The rank #{rank} and file #{file} is invalid." \
            " Valid ranges are 0-7 and a-h respectively."
      super(msg)
    end
  end
end
