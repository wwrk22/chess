require './lib/move/move'
require './lib/standards/piece'

class PawnMoveInterpreter
  
  # Takes the raw format of a non-capture move
  # (e.g. { move: { file: 'a', rank: 3 }, color: Piece::WH }), then interprets
  # it to construct and return a Move object. The raw move should have had its
  # syntax and color validated by a validator before being passed to this
  # interpreter.
  def interpret_move(raw_move, interpreted_move = Move.new)
    set_piece_info(interpreted_move, raw_move[:color])
    interpreted_move.starts = compute_starts(raw_move[:move], raw_move[:color])
    interpreted_move.target_sq = raw_move[:move]
    interpreted_move
  end

  # For the given color, compute all squares that a pawn could be starting from
  # to get to the target square.
  def compute_starts(target_sq, color, sqs = [])
    compute_starts_wh(target_sq, sqs) if color == Piece::WH
    compute_starts_bl(target_sq, sqs) if color == Piece::BL
    sqs
  end

  # Takes the raw format of a capture move
  # (e.g. { start_file: 'b', move: { file: 'a', rank: 3 }, color: Piece::WH }),
  # and interprets it to construct then return a Move object. The raw move
  # should have had its syntax and color validated by a validator before being
  # passed to this interpreter.
  def interpret_capture(raw_move, interpreted_move = Move.new)
    set_piece_info(interpreted_move, raw_move[:color])
    interpreted_move.target_sq = raw_move[:move]
    interpreted_move.capture = true

    if raw_move[:color] == Piece::WH
      interpreted_move.starts = [{ file: raw_move[:start_file], rank: raw_move[:move][:rank] - 1 }]
    else
      interpreted_move.starts = [{ file: raw_move[:start_file], rank: raw_move[:move][:rank] + 1 }]
    end

    interpreted_move
  end


  private

  def set_piece_info(interpreted_move, color)
    interpreted_move.piece_type = Piece::PA
    interpreted_move.color = color
    interpreted_move.opp_color = (color == Piece::WH) ? Piece::BL : Piece::WH
  end

  def compute_starts_wh(target_sq, sqs)
    sqs << { file: target_sq[:file], rank: target_sq[:rank] - 1 }

    if target_sq[:rank] == 4
      sqs << { file: target_sq[:file], rank: target_sq[:rank] - 2 }
    end
  end

  def compute_starts_bl(target_sq, sqs)
    sqs << { file: target_sq[:file], rank: target_sq[:rank] + 1 }

    if target_sq[:rank] == 5
      sqs << { file: target_sq[:file], rank: target_sq[:rank] + 2 }
    end
  end
end