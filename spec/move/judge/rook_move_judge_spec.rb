require './lib/move/judge/rook_move_judge'
require './lib/standard/chess_piece'
require './lib/board/board'


RSpec.describe RookMoveJudge do
  describe '#judge_move' do
    subject(:judge) { described_class.new }

    context "when the target square is not empty" do
      it "returns false" do
        start_sq = { file: 'a', rank: 1 }
        target_sq = { file: 'a', rank: 5 }
        player_color = ChessPiece::WH
        board = instance_double(Board)

        allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return('some chess piece')

        expect(judge.judge_move(start_sq, target_sq, player_color, board)).to be_falsey
      end
    end

    context "when the target square is empty" do
    end
  end
end
