require './lib/move/interpreter/pawn_move_interpreter'
require './lib/move/move'
require './lib/standards/piece'

RSpec.describe PawnMoveInterpreter do
  describe '#compute_starts' do
    subject(:interpreter) { described_class.new }

    context "when player color is white" do
      context "when target square rank is not 4" do
        it "returns an array of the square below the target square" do
          exp_result = [{ file: 'a', rank: 2 }]
          target_sq = { file: 'a', rank: 3 }
          result = interpreter.compute_starts(target_sq, Piece::WH)
          expect(result).to eq(exp_result)
        end
      end

      context "when target square rank is 4" do
        it "returns an array of the two squares below the target square" do
          exp_result = [{ file: 'a', rank: 3 }, { file: 'a', rank: 2 }]
          target_sq = { file: 'a', rank: 4 }
          result = interpreter.compute_starts(target_sq, Piece::WH)
          expect(result).to eq(exp_result)
        end
      end
    end # context "when player color is white"

    context "when player color is black" do
      context "when target square rank is not 5" do
        it "returns an array of the square above the target square" do
          exp_result = [{ file: 'a', rank: 7 }]
          target_sq = { file: 'a', rank: 6 }
          result = interpreter.compute_starts(target_sq, Piece::BL)
          expect(result).to eq(exp_result)
        end
      end
      
      context "when target square rank is 5" do
        it "returns an array of the two squares above the target square" do
          exp_result = [{ file: 'a', rank: 6 }, { file: 'a', rank: 7 }]
          target_sq = { file: 'a', rank: 5 }
          result = interpreter.compute_starts(target_sq, Piece::BL)
          expect(result).to eq(exp_result)
        end
      end
    end # context "when player color is black"
  end # describe '#compute_possble_start_sqs'

  describe '#interpret_move' do
    subject(:interpreter) { described_class.new }

    matcher :be_same_as do |other_move|
      match do |move|
        move.starts == other_move.starts &&
        move.target_sq == other_move.target_sq &&
        move.piece_type == other_move.piece_type &&
        move.color == other_move.color &&
        move.opp_color == other_move.opp_color
      end
    end

    context "when player color is white" do
      it "returns a Move object with correctly populated values" do
        exp_result = Move.new
        exp_result.starts = [{ file: 'a', rank: 2 }]
        exp_result.target_sq = { file: 'a', rank: 3}
        exp_result.piece_type = Piece::PA
        exp_result.color = Piece::WH
        exp_result.opp_color = Piece::BL
        result = interpreter.interpret_move({ move: { file: 'a', rank: 3 }, color: Piece::WH })
        expect(result).to be_same_as(exp_result)
      end
    end

    context "when player color is black" do
      it "returns a Move object with correctly populated values" do
        exp_result = Move.new
        exp_result.starts = [{ file: 'a', rank: 7 }]
        exp_result.target_sq = { file: 'a', rank: 6 }
        exp_result.piece_type = Piece::PA
        exp_result.color = Piece::BL
        exp_result.opp_color = Piece::WH
        result = interpreter.interpret_move({ move: { file: 'a', rank: 6 }, color: Piece::BL })
        expect(result).to be_same_as(exp_result)
      end
    end
  end # describe '#interpret_move'

  describe '#interpret_capture' do
    subject(:interpreter) { described_class.new }

    context "when player color is white" do
      it "returns a Move object with correct possible start squares" do
        exp_starts = [{ file: 'b', rank: 2 }]
        move = interpreter.interpret_capture({ start_file: 'b', move: { file: 'a', rank: 3 }, color: Piece::WH })
        expect(move.starts).to eq(exp_starts)
      end
    end

    context "when player color is black" do
      it "returns a Move object with correct possible start squares" do
        exp_starts = [{ file: 'b', rank: 7 }]
        move = interpreter.interpret_capture({ start_file: 'b', move: { file: 'a', rank: 6 }, color: Piece::BL })
        expect(move.starts).to eq(exp_starts)
      end
    end
  end # describe '#interpret_capture'
end
