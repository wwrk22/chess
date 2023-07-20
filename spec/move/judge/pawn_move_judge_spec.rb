require './lib/move/judge/pawn_move_judge'
require './lib/board/board'
require './lib/move/pawn_move'


RSpec.describe PawnMoveJudge do
  describe '#judge' do
    context "when the move is not a capture" do
      context "when there is one start square" do
        subject(:judge) { described_class.new }

        it "calls #check_target on the start and target squares" do
          move = PawnMove.new
          move.target = { file: 'a', rank: 3 }
          move.starts = [{ file: 'a', rank: 2 }]
          move.capture = false
          board = instance_double(Board)
          allow(judge).to receive(:check_target).with(move.target, board).and_return(true)
          allow(judge).to receive(:check_target).with(move.starts[0], board, move.moving_piece).and_return(true)
          expect(judge.judge_move(move, board)).to eq(true)
        end
      end

      context "when there are two start squares" do
        subject(:judge) { described_class.new }

        
      end
    end # context "when the move is not a capture"

    context "when the move is a capture" do
    end # context "when the move is a capture"
  end
end
