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
          target = { file: 'a', rank: 3 }
          start = { file: 'a', rank: 2 }
          board = instance_double(Board)
          expect(judge).to receive(:check_target).with(target, board).once
          expect(judge).to receive(:check_target).with(start, board, move.moving_piece).once
          judge.judge_move(move)
        end
      end

      context "when there are two start squares" do
      end
    end # context "when the move is not a capture"

    context "when the move is a capture" do
    end # context "when the move is a capture"
  end
end
