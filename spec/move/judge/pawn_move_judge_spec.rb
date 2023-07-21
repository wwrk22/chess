require './lib/move/judge/pawn_move_judge'
require './lib/board/board'
require './lib/move/pawn_move'
require './lib/standard/chess_piece'


RSpec.describe PawnMoveJudge do
  describe '#judge_single_move' do
    context "when target square is empty" do
      context "when start square has the moving pawn" do
        subject(:judge) { described_class.new }

        it "returns true" do
          target_sq = { file: 'a', rank: 3 }
          start_sq = { file: 'a', rank: 2 }
          pawn = { type: ChessPiece::PA, color: ChessPiece::WH }
          board = instance_double(Board)

          allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(nil)
          allow(judge).to receive(:check_target).with(target_sq, board, pawn).and_return(true)
          expect(judge.judge_single_move(target_sq, start_sq, pawn[:color], board)).to eq(true)
        end
      end

      context "when start square has the wrong chess piece" do
      end

      context "when start square is empty" do
      end
    end

    context "when target square is not empty" do
      subject(:judge) { described_class.new }

      it "returns false" do
        target_sq = { file: 'a', rank: 3 }
        start_sq = { file: 'a', rank: 2 }
        pawn_color = ChessPiece::WH
        board = instance_double(Board)

        allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return('a chess piece')
        expect(judge.judge_single_move(target_sq, start_sq, pawn_color, board)).to eq(false)
      end
    end
  end
end
