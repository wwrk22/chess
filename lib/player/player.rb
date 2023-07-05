class Player
  attr_reader :name, :color

  def initialize(name, color)
    @name = name
    @color = color
  end

  # Prompt the player for a move, then return a formatted hash of the move.
  def prompt_move
    input = gets.chomp
    return { move: input, color: @color }
  end
end
