require './lib/move/move'
require_relative './move_interpreter'
require './lib/standards/piece'
require_relative '../move'

class PawnMoveInterpreter < MoveInterpreter
  def initialize(color)
    super(color)
  end
  
  # Take the string format of a move, then interpret it to construct and return
  # a Move object. The input move must be validated before being interpreted.
  def interpret(move_str, move)
    move.target = parse_target(move_str)
    move.piece = parse_piece(move_str)
    move.capture = capture? move_str
    move.compute_starts
    move
  end
end
