require_relative './move_interpreter'
require './lib/standards/board_standards'
require './lib/move/move'
require './lib/board/board'

class RookMoveInterpreter < MoveInterpreter
  def initialize(color)
    super(color)
  end

  def interpret(move_str)
    move = Move.new
    init_move(move_str, move)

    move.starts = compute_starts(move)

    # Raise error to indicate #compute_starts didn't have all of the info
    # needed and never called the block.
    # Return nil for now
    nil
  end

  private

  def compute_starts(move)
    move.compute_starts do |data|
      compute_all_starts(data)
    end
  end

  def compute_all_starts(data)
    return compute_with_start_file(data) if data[:start_f]
    return compute_with_start_rank(data) if data[:start_r]
    return compute_all_directions(data)
  end

  def compute_all_directions(data)
    target_square_file = Board.get_line(data[:target][:f])
    target_square_rank = Board.get_line(data[:target][:r])
    starts = target_square_file.concat(target_square_rank)
    starts.delete({ f: data[:target][:f], r: data[:target][:r] })
    starts
  end

  def compute_with_start_file(data)
    if data[:start_f] != data[:target][:f]
      [{ f: data[:start_f], r: data[:target][:r] }]
    else # Start file is specified but same as target file
      Board.get_line(data[:start_f])
    end
  end

  def compute_with_start_rank(data)
    if data[:start_r] != data[:target][:r]
      [{ f: data[:target][:f], r: data[:start_r] }]
    else # Start rank is specified but same as target rank
      Board.get_line(data[:start_r])
    end
  end

  def init_move(move_str, move)
    move.target = parse_target(move_str)
    move.piece = parse_piece(move_str)
    move.color = @color
    move.capture = capture? move_str
    set_start_f_or_r(move_str, move)
  end
end
