require './lib/piece/piece_specs'
require './lib/standard/chess_board'
require_relative './pawn_validator'
require_relative './rook_validator'
require_relative './knight_validator'
require_relative './bishop_validator'
require_relative './queen_validator'
require_relative './king_validator'


class Validator
  include PieceSpecs

  def initialize
    @pawn_validator = PawnValidator.new
    @rook_validator = RookValidator.new
    @knight_validator = KnightValidator.new
    @bishop_validator = BishopValidator.new
    @queen_validator = QueenValidator.new
    @king_validator = KingValidator.new
  end

  def validate(move_str, color)
    case parse_piece(move_str)
    when pawn
      @pawn_validator.validate(move_str, color)
    when rook
      @rook_validator.validate(move_str, color)
    when knight
      @knight_validator.validate(move_str, color)
    when bishop
      @bishop_validator.validate(move_str, color)
    when queen
      @queen_validator.validate(move_str, color)
    when king
      @king_validator.validate(move_str, color)
    else
      false
    end
  end

  def parse_piece(move_str)
    return pawn if ChessBoard::FILES.include? move_str[0]
    return move_str[0]
  end

end # Validator
