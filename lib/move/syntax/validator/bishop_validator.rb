require_relative '../pattern/bishop'
require './lib/error/color_unknown_error'
require './lib/piece/piece_specs'
require './lib/piece/bishop'


class BishopValidator
  include PieceSpecs
  include MoveSyntax::Bishop

  # Return the move if move has valid syntax. Otherwise, return nil.
  def validate(move_str, color)
    Bishop.new(color) if move_str =~ bishop_move_syntax
  end
end
