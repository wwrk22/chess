require './lib/move/move'
require_relative './move_interpreter'
require './lib/standards/piece'

# Interpret pawn moves for one color to output a Move object that gives the
# necessary information to determine the legality of the move.
class PawnMoveInterpreter < MoveInterpreter
  def initialize(color)
    super(color)
  end
  
  # Take the string format of a move, then interpret it to construct and return
  # a Move object. The input move must be validated before being interpreted.
  def interpret(move_str)
    move = Move.new
    init_move(move_str, move)
    return move if compute_starts(move)
    
    # Raise error to indicate #compute_starts didn't have all of the info
    # needed and never called the block.
    # Return nil for now
    nil
  end

  private

  def compute_starts(move)
    move.compute_starts do |data|
      if move.capture
        compute_capture_starts(data)
      else # move is not a capture
        compute_move_starts(data)
      end
    end
  end

  def compute_move_starts(data)
    if data[:color] == Piece::WH
      return white_move_starts(data[:target][:f], data[:target][:r])
    else
      return black_move_starts(data[:target][:f], data[:target][:r])
    end
  end

  def compute_capture_starts(data)
    if data[:color] == Piece::WH
      return [{ f: data[:start_f], r: data[:target][:r] - 1 }]
    else
      return [{ f: data[:start_f], r: data[:target][:r] + 1 }]
    end
  end

  def white_move_starts(target_f, target_r, starts = [])
      starts << { f: target_f, r: target_r - 1 }

      if target_r == 4
        starts << { f: target_f, r: target_r - 2 }
      end

      starts
  end

  def black_move_starts(target_f, target_r, starts = [])
      starts << { f: target_f, r: target_r + 1 }

      if target_r == 5
        starts << { f: target_f, r: target_r + 2 }
      end

      starts
  end

  def return_non_capture_move_start_sqs(data)
  end

  def init_move(move_str, move)
    move.target = parse_target(move_str)
    move.piece = parse_piece(move_str)
    move.color = @color
    move.capture = capture? move_str
    move.start_f = move_str[0] if move.capture
  end
end
