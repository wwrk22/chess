require './lib/board/board_specs'
require './lib/piece/piece_specs'
require_relative './pawn_validator'
require_relative './rook_validator'
require_relative './knight_validator'
require_relative './bishop_validator'
require_relative './queen_validator'
require_relative './king_validator'


class Validator
  include PieceSpecs
  include BoardSpecs

  def initialize
    @validators = { pawn => PawnValidator.new, rook => RookValidator.new,
                    knight => KnightValidator.new, bishop => BishopValidator.new,
                    queen => QueenValidator.new, king => KingValidator.new }
  end

  ##
  # Validate the syntax of the move given. If the syntax is valid, then return
  # the ChessPiece object that represents the moving piece type to indicate so.
  # Otherwise, return nil to indicate that the move has invalid syntax.
  def validate(move_str, color)
    piece_type = parse_piece(move_str)
    return false if piece_type.nil?
    return @validators[piece_type].validate(move_str, color)
  end

  def parse_piece(move_str)
    return pawn if valid_file? move_str[0]
    return move_str[0] if valid_piece? move_str[0]
  end

end # Validator
