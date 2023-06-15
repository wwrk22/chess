require './lib/move/interpreter/pawn_move_interpreter'
require './lib/move/move'
require './lib/standards/piece'

RSpec.describe PawnMoveInterpreter do
  describe '#compute_possible_start_sqs' do
    subject(:interpreter) { described_class.new }

    context "when player color is white" do
      context "when target square rank is not 4" do
        it "returns an array of the square below the target square" do
          exp_result = [{ file: 'a', rank: 2 }]
          target_sq = { file: 'a', rank: 3 }
          result = interpreter.compute_possible_start_sqs(target_sq, Piece::WH)
          expect(result).to eq(exp_result)
        end
      end

      context "when target square rank is 4" do
        it "returns an array of the two squares below the target square" do
          exp_result = [{ file: 'a', rank: 3 }, { file: 'a', rank: 2 }]
          target_sq = { file: 'a', rank: 4 }
          result = interpreter.compute_possible_start_sqs(target_sq, Piece::WH)
          expect(result).to eq(exp_result)
        end
      end
    end # context "when player color is white"

    context "when player color is black" do
      context "when target square rank is not 5" do
        it "returns an array of the square above the target square" do
          exp_result = [{ file: 'a', rank: 7 }]
          target_sq = { file: 'a', rank: 6 }
          result = interpreter.compute_possible_start_sqs(target_sq, Piece::BL)
          expect(result).to eq(exp_result)
        end
      end
      
      context "when target square rank is 5" do
        it "returns an array of the two squares above the target square" do
          exp_result = [{ file: 'a', rank: 6 }, { file: 'a', rank: 7 }]
          target_sq = { file: 'a', rank: 5 }
          result = interpreter.compute_possible_start_sqs(target_sq, Piece::BL)
          expect(result).to eq(exp_result)
        end
      end
    end # context "when player color is black"
  end # describe '#compute_possble_start_sqs'
end
