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
    @validators = { pawn => PawnValidator.new, rook => RookValidator.new,
                    knight => KnightValidator.new, bishop => BishopValidator.new,
                    queen => QueenValidator.new, king => KingValidator.new }
  end

  ##
  # Validate the syntax of the move given. If the syntax is valid, then return
  # the letter that represents the moving piece type to indicate so. Otherwise,
  # return nil to indicate that the move has invalid syntax.
  def validate(move_str, color)
    piece_type = parse_piece(move_str)

    if @validators.has_key? piece_type
      return @validators[piece_type].validate(move_str, color)
    end

    nil
  end

  def parse_piece(move_str)
    return pawn if ChessBoard::FILES.include? move_str[0]
    return move_str[0]
  end

end # Validator
