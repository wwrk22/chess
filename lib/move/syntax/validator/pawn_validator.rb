require_relative '../move/pawn_moves'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


class PawnValidator
  include PieceSpecs

  # Return the ChessPiece object representing the moving pawn if move has valid
  # syntax. Otherwise, return nil. Raise ColorUnknownError if color is unknown.
  def validate(move_str, color)
    raise ColorUnknownError.new(color) if valid_color?(color) == false

    return move_str.include?('x') ?
      validate_capture(move_str, color) :
      validate_non_capture(move_str, color)
  end

  # Validate a move that is a capture. Raise ColorUnknownError if color is
  # unknown.
  def validate_capture(move_str, color)
    capture_patterns = (color == white) ? PawnMoves::WH_CAPTURES : PawnMoves::BL_CAPTURES
    capture_patterns.one? { |pattern| move_str =~ pattern } ?
      ChessPiece.new(pawn, color) : nil
  end

  # Validate a move that is not a capture. Raise ColorUnknownError if color
  # is unknown.
  def validate_non_capture(move_str, color)
    move_pattern = (color == white) ? PawnMoves::WH_MOVE : PawnMoves::BL_MOVE
    return move_str =~ move_pattern ? ChessPiece.new(pawn, color) : nil
  end
end
