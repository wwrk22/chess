require './lib/standard/chess_piece'
require './lib/standard/chess_board'
require_relative './pawn_validator'
require_relative './rook_validator'
require_relative './knight_validator'
require_relative './bishop_validator'
require_relative './queen_validator'
require_relative './king_validator'


class Validator

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
    when ChessPiece::PA
      @pawn_validator.validate(move_str, color)
    when ChessPiece::RO
      @rook_validator.validate(move_str, color)
    when ChessPiece::KN
      @knight_validator.validate(move_str, color)
    when ChessPiece::BI
      @bishop_validator.validate(move_str, color)
    when ChessPiece::QU
      @queen_validator.validate(move_str, color)
    when ChessPiece::KI
      @king_validator.validate(move_str, color)
    else
      false
    end
  end

  def parse_piece(move_str)
    return ChessPiece::PA if ChessBoard::FILES.include? move_str[0]
    return move_str[0]
  end

end # Validator
