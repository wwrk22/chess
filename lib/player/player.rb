require './lib/board/board'
require './lib/error/color_unknown_error'
require './lib/move/syntax/validator/validator'
require './lib/piece/piece_specs'
require './lib/move/move'
require './lib/move/interpreter/move_interpreter'


class Player
  include PieceSpecs

  attr_reader :name, :color
  attr_accessor :last_move # Store the last move that was made.

  def initialize(name, color)
    raise ColorUnknownError.new if not valid_color? color

    @name = name
    @color = color
    @validator = Validator.new
    @interpreter = MoveInterpreter.new
  end

  def prompt_move(board)
    move_str = gets.chomp

    if move_str == '0-0' || move_str == '0-0-0'
      return Move.new(move_str, @color)
    end

    piece = @validator.validate(move_str, @color)

    if piece
      capture = move_str.include?('x') ? true : false
      move = Move.new(move_str, @color, capture)
      move.piece = piece
      move.target = @interpreter.parse_target(move.str)

      target = board.at(move.target)

      if target && target.eql?(piece)
        return nil
      else
        return move
      end
    end
  end
end
