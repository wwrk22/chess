require './lib/standard/chess_piece'
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

  def validate(move, piece_type)
    case piece_type
    when ChessPiece::PA
      @pawn_validator.validate(move)
    when ChessPiece::RO
      @rook_validator.validate(move)
    when ChessPiece::KN
      @knight_validator.validate(move)
    when ChessPiece::BI
      @bishop_validator.validate(move)
    when ChessPiece::QU
      @queen_validator.validate(move)
    when ChessPiece::KI
      @king_validator.validate(move)
    else
      false
    end
  end

end # Validator
