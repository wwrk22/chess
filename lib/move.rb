class Move
  attr_accessor :piece_type, :start_sq, :target_sq, :player_color, :opp_color
  attr_accessor :capture?, :en_passant, :possible_start_sqs
end
