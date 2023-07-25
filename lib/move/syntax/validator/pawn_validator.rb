require_relative '../move/pawn_moves'
require './lib/standard/chess_piece'


class PawnValidator

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    return validate_capture_move(move_str, player_color) if move_str.include? 'x'
    return validate_non_capture_move(move_str, player_color)
  end

  private

  # Validate a move that is a capture. Raise ColorUnknownError if color is
  # unknown.
  def validate_capture_move(move_str, player_color)
    return check_white_capture(move_str) if player_color == ChessPiece::WH
    return check_black_capture(move_str) if player_color == ChessPiece::BL
    raise ColorUnknownError.new(player_color)
  end

  # Compare move string against white pawn capture-move syntax regex.
  def check_white_capture(move_str)
    PawnMoves::WH_CAPTURES.each do |capture|
      return move_str if move_str =~ capture
    end

    nil
  end

  # Compare move string against black pawn capture-move syntax regex.
  def check_black_capture(move_str)
    PawnMoves::BL_CAPTURES.each do |capture|
      return move_str if move_str =~ capture
    end

    nil
  end

  # Validate a move that is not a capture. Raise ColorUnknownError if color
  # is unknown.
  def validate_non_capture_move(move_str, player_color)
    return check_white_move(move_str) if player_color == ChessPiece::WH
    return check_black_move(move_str) if player_color == ChessPiece::BL
    raise ColorUnknownError.new(player_color)
  end

  # Compare move string against white pawn move syntax regex.
  def check_white_move(move_str)
    return move_str if move_str =~ PawnMoves::WH_MOVE
  end

  # Compare move string against black pawn move syntax regex.
  def check_black_move(move_str)
    return move_str if move_str =~ PawnMoves::BL_MOVE
  end

end
