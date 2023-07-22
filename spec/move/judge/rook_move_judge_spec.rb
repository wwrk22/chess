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
    end # context "when the target square is not empty"

    context "when the target square is empty" do
      let!(:player_rook) { { type: ChessPiece::RO, color: player_color } }

      before :example do
        allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(nil)
      end

      context "when the start square does not have the player's rook" do
        it "returns false" do
          allow(judge).to receive(:check_target).with(start_sq, board, player_rook).and_return(false)

          expect(judge.judge_move(start_sq, target_sq, player_color, board)).to be_falsey
        end
      end

      context "when the start square has the player's rook" do
        it "calls #clear_path? to check if the path between start and target is clear" do
          direction = { file: 0, rank: 4 }
          allow(judge).to receive(:check_target).with(start_sq, board, player_rook).and_return(true)
          allow(judge).to receive(:compute_direction).with(start_sq, target_sq).and_return(direction)

          expect(judge).to receive(:clear_path?).with(start_sq, target_sq, board, direction)
          judge.judge_move(start_sq, target_sq, player_color, board)
        end
      end # context "when the start square has the player's rook"
    end # context "when the target square is empty"
  end # describe '#judge_move'

  
end
