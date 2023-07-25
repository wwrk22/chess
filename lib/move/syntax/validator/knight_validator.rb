require_relative '../move/knight_moves'
require './lib/error/color_unknown_error'
require './lib/standard/chess_piece'


class KnightValidator

  # Return the move if move has valid syntax. Otherwise, return nil.
  # Raise ColorUnknownError if color is unknown.
  def validate(move_str, player_color)
    if player_color != ChessPiece::WH && player_color != ChessPiece::BL
      raise ColorUnknownError.new(player_color)
    end

    check_syntax(move_str)
  end

  private

  def check_syntax(move_str)
    KnightMoves::MOVES.each do |pattern|
      return move_str if move_str =~ pattern
    end

    nil
  end

end
