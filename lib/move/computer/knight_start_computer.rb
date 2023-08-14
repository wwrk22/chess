require './lib/board/board_specs'
require './lib/piece/knight_specs'


# Computes the required information for use by the chess board in order to
# perform a move with a knight.
class KnightStartComputer
  include BoardSpecs
  include KnightSpecs
  
  def compute_start(move, board)
    return nil if move.piece.nil? || move.target.nil?

    starts = all_possible_starts(move.target)
    find_knight(move.piece, board, starts)
  end

  def find_knight(knight, board, starts)
    starts.filter! { |start| board.at(start).eql? knight }
    starts[0] if starts.size == 1
  end

  def all_possible_starts(target_sq)
    starts = top_half_starts(target_sq[:file], target_sq[:rank]) +
      bottom_half_starts(target_sq[:file], target_sq[:rank])

    starts.filter { |start| valid_square?(start) }
  end


  private

  def top_half_starts(file, rank)
    [{ file: (file.ord + dir[0][:file]).chr, rank: rank + dir[0][:rank] },
     { file: (file.ord + dir[1][:file]).chr, rank: rank + dir[1][:rank] },
     { file: (file.ord + dir[2][:file]).chr, rank: rank + dir[2][:rank] },
     { file: (file.ord + dir[3][:file]).chr, rank: rank + dir[3][:rank] }]
  end

  def bottom_half_starts(file, rank)
    [{ file: (file.ord + dir[4][:file]).chr, rank: rank + dir[4][:rank] },
     { file: (file.ord + dir[5][:file]).chr, rank: rank + dir[5][:rank] },
     { file: (file.ord + dir[6][:file]).chr, rank: rank + dir[6][:rank] },
     { file: (file.ord + dir[7][:file]).chr, rank: rank + dir[7][:rank] }]
  end
end
