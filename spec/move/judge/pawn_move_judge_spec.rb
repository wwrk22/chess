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
          allow(judge).to receive(:check_target).with(start_sq, board, pawn).and_return(true)
          expect(judge.judge_single_move(target_sq, start_sq, pawn[:color], board)).to be_truthy
        end
      end

      context "when start square does not have the moving pawn" do
        it "returns false" do
          allow(judge).to receive(:check_target).with(start_sq, board, pawn).and_return(false)
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


  describe '#judge_double_move' do
    subject(:judge) { described_class.new }
    let!(:board) { instance_double(Board) }

    context "when the pawn is white" do
      let!(:target_sq) { { file: 'a', rank: 4 } }
      let!(:middle_sq) { { file: 'a', rank: 3 } }
      let!(:start_sq) { { file: 'a', rank: 2 } }

      context "when the middle square is not empty" do
        it "returns false" do
          allow(board).to receive(:at).with(middle_sq[:file], middle_sq[:rank]).and_return('a chess piece')
          expect(judge.judge_double_move(target_sq, start_sq, ChessPiece::WH, board)).to be_falsey
        end
      end # context "when the middle square is not empty"

      context "when the middle square is empty" do
        it "calls #judge_single_move and returns its value" do
          allow(board).to receive(:at).with(middle_sq[:file], middle_sq[:rank]).and_return(nil)
          expect(judge).to receive(:judge_single_move).with(target_sq, start_sq, ChessPiece::WH, board)
          judge.judge_double_move(target_sq, start_sq, ChessPiece::WH, board)
        end
      end
    end # context "when the pawn is white"

    context "when the pawn is black" do
      let!(:target_sq) { { file: 'a', rank: 5 } }
      let!(:middle_sq) { { file: 'a', rank: 6 } }
      let!(:start_sq) { { file: 'a', rank: 7 } }

      context "when the middle square is not empty" do
        it "returns false" do
          allow(board).to receive(:at).with(middle_sq[:file], middle_sq[:rank]).and_return('a chess piece')
          expect(judge.judge_double_move(target_sq, start_sq, ChessPiece::BL, board)).to be_falsey
        end
      end

      context "when the middle square is empty" do
        it "calls #judge_single_move and returns its value" do
          allow(board).to receive(:at).with(middle_sq[:file], middle_sq[:rank]).and_return(nil)
          expect(judge).to receive(:judge_single_move).with(target_sq, start_sq, ChessPiece::BL, board)
          judge.judge_double_move(target_sq, start_sq, ChessPiece::BL, board)
        end
      end
    end # context "when the pawn is black"
  end # describe '#judge_double_move'


  describe '#judge_capture' do
    subject(:judge) { described_class.new }

    context "when the pawn is white" do
      context "when target square does not have an opponent chess piece" do
        let!(:target_sq) { { file: 'b', rank: 3 } }
        let!(:start_file) { 'a' }
        let!(:board) { instance_double(Board) }

        it "returns false" do
          allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(nil)
          expect(judge.judge_capture(target_sq, start_file, ChessPiece::WH, board)).to be_falsey
        end
      end
    end # context "when the pawn is white"
  end # describe '#judge_capture'
end
