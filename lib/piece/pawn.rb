require_relative './chess_piece'
require_relative './piece_specs'
require './lib/error/color_unknown_error'


class Pawn < ChessPiece
  include PieceSpecs

  UNICODE_WH = "\u2659"
  UNICODE_BL = "\u265F"
  private_constant :UNICODE_WH, :UNICODE_BL

  attr_reader :color

  ##
  # Create a new chess piece with its color. Raise error for unknown color.
  def initialize(color)
    if color == white || color == black
      @color = color
    else
      raise ColorUnknownError.new(color)
    end
  end

  def unicode
    return @color == white ? UNICODE_WH : UNICODE_BL
  end

  class << self
    def unicode_wh
      UNICODE_WH
    end

    def unicode_bl
      UNICODE_BL
    end
  end
end
