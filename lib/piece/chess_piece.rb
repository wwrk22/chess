require './lib/error/color_unknown_error'


class ChessPiece
  
  attr_reader :color

  def initialize(color)
    if color == white || color == black
      @color = color
    else
      raise ColorUnknownError.new(color)
    end
  end
end
