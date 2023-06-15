class Move
  attr_accessor :starts, :start_sq, :target_sq
  attr_accessor :piece_type, :color, :opp_color
  attr_accessor :capture, :en_passant

  def initialize
    @capture = false
    @en_passant = false
  end
end
