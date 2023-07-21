require './lib/move/judge/pawn_move_judge'
require './lib/board/board'
require './lib/move/pawn_move'
require './lib/standard/chess_piece'


RSpec.describe PawnMoveJudge do
  describe '#judge_single_move' do
    subject(:judge) { described_class.new }

    let!(:target_sq) { { file: 'a', rank: 3 } }
    let!(:start_sq) { { file: 'a', rank: 2 } }
    let!(:pawn) { { type: ChessPiece::PA, color: ChessPiece::WH } }
    let!(:board) { instance_double(Board) }

    context "when target square is empty" do
      before :example do
        allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(nil)
      end

      context "when start square has the moving pawn" do
        it "returns true" do
          allow(judge).to receive(:check_target).with(target_sq, board, pawn).and_return(true)
          expect(judge.judge_single_move(target_sq, start_sq, pawn[:color], board)).to be_truthy
        end
      end

      context "when start square does not have the moving pawn" do
        it "returns false" do
          allow(judge).to receive(:check_target).with(target_sq, board, pawn).and_return(false)
          expect(judge.judge_single_move(target_sq, start_sq, pawn[:color], board)).to be_falsey
        end
      end
    end # context "when target square is empty"

    context "when target square is not empty" do
      it "returns false" do
        allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return('a chess piece')
        expect(judge.judge_single_move(target_sq, start_sq, pawn[:color], board)).to be_falsey
      end
    end # context "when target square is not empty"
  end # describe '#judge_single_move'
end
