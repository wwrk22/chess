require './lib/error/color_unknown_error'
require_relative './piece_specs'


class ChessPiece
  include PieceSpecs
  
  attr_reader :type, :color
  attr_accessor :made_first_move

  def initialize(type, color)
    raise ColorUnknownError.new(color) if color != white && color != black
    @color = color
    @type = type
    @made_first_move = false
  end

  ##
  # [Abstract]
  # A subclass representing a kind of ChessPiece should return the unicode
  # string for the visual representation.
  def unicode; raise "SubclassResponsibility"; end

  def eql?(other_piece)
    @type == other_piece.type && @color == other_piece.color
  end
end
