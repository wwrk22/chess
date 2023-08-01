require_relative '../move/rook_moves'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


class RookValidator
  include PieceSpecs

  # Return the ChessPiece object representing the moving rook if move has valid
  # syntax. Otherwise, return nil. Raise ColorUnknownError if color is unknown.
  def validate(move_str, color)
    raise ColorUnknownError.new(color) if valid_color?(color) == false
    return validate_capture(move_str) if move_str.include? 'x'
    return ChessPiece.new(rook, color) if move_str =~ RookMoves::MOVE
  end

  def validate_capture(move_str, color)
    match = RookMoves::CAPTURES.one? { |capture| move_str =~ capture }
    match ? ChessPiece.new(rook, color) : nil
  end

end
