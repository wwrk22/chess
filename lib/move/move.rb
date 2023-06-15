class Move
  attr_accessor :possible_start_sqs, :start_sq, :target_sq
  attr_accessor :piece_type, :color, :opp_color
  attr_accessor :capture, :en_passant
end
