require './lib/move/move'
require './lib/standards/piece'

class PawnMoveInterpreter
  
  # Takes the raw format of a move (e.g. { move: 'a3', color: Piece::WH }, and
  # interprets it to construct then return a Move object.
  # The raw move should have had its syntax and color validated by a validator
  # before being passed to this interpreter.
  def interpret_move(raw_move)
    interpreted_move = Move.new

    interpreted_move.color = raw_move[:color]

    if interpreted_move.color == Piece::WH
      interpreted_move.opp_color = Piece::BL
    else
      interpreted_move.opp_color = Piece::WH
    end

    interpreted_move.piece_type = Piece::PA

    #interpreted_move.target_sq = parse_target_sq(raw_move[:move])

    #compute_possible_start_sqs(interpreted_move)
  end

  def compute_possible_start_sqs(target_sq, color, sqs = [])
    compute_possible_start_sqs_wh(target_sq, sqs) if color == Piece::WH
    compute_possible_start_sqs_bl(target_sq, sqs) if color == Piece::BL
    sqs
  end


  private

  def compute_possible_start_sqs_wh(target_sq, sqs)
    sqs << { file: target_sq[:file], rank: target_sq[:rank] - 1 }

    if target_sq[:rank] == 4
      sqs << { file: target_sq[:file], rank: target_sq[:rank] - 2 }
    end
  end

  def compute_possible_start_sqs_bl(target_sq, sqs)
    sqs << { file: target_sq[:file], rank: target_sq[:rank] + 1 }

    if target_sq[:rank] == 5
      sqs << { file: target_sq[:file], rank: target_sq[:rank] + 2 }
    end
  end
end
