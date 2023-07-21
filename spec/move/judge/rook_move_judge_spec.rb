require './lib/move/judge/rook_move_judge'
require './lib/standard/chess_piece'
require './lib/board/board'


RSpec.describe RookMoveJudge do
  describe '#judge_move' do
    subject(:judge) { described_class.new }
    
    let!(:start_sq) { { file: 'a', rank: 1 } }
    let!(:target_sq) { { file: 'a', rank: 5 } }
    let!(:player_color) { ChessPiece::WH }
    let!(:board) { instance_double(Board) }

    context "when the target square is not empty" do
      it "returns false" do
        allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return('some chess piece')
        expect(judge.judge_move(start_sq, target_sq, player_color, board)).to be_falsey
      end
    end

    context "when the target square is empty" do
      context "when the start square does not have the player's rook" do
        it "returns false" do
          player_rook = { type: ChessPiece::RO, color: player_color }
          allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(nil)
          allow(judge).to receive(:check_target).with(start_sq, board, player_rook).and_return(false)
          expect(judge.judge_move(start_sq, target_sq, player_color, board)).to be_falsey
        end
      end

      context "when the start square has the player's rook" do
      end
    end
  end
end
