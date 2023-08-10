require_relative '../pattern/queen'
require './lib/piece/queen'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


class QueenValidator
  include PieceSpecs
  include MoveSyntax::Queen

  # Return the move if move has valid syntax. Otherwise, return nil.
  def validate(move_str, color)
    Queen.new(color) if move_str =~ queen_move_syntax
  end
end
