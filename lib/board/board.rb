require './lib/standards/board_standards'

class Board

  class << self

    def get_line(f_or_r)
      if BoardStandards::FILES.include? f_or_r.to_s
        get_file(f_or_r)
      else
        get_rank(f_or_r)
      end
    end

    private

    def get_file(file)
      (1..8).reduce([]) do |line, r|
        line << { f: file, r: r }
      end
    end

    def get_rank(rank)
      BoardStandards::FILES.each_char.reduce([]) do |line, f|
        line << { f: f, r: rank }
      end
    end

  end # class << self
end
