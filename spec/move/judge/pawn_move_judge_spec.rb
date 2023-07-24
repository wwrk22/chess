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
          allow(judge).to receive(:check_square).with(start_sq, board, pawn[:color], pawn[:type]).and_return(true)
          expect(judge.judge_single_move(target_sq, start_sq, pawn[:color], board)).to be_truthy
        end
      end

      context "when start square does not have the moving pawn" do
        it "returns false" do
          allow(judge).to receive(:check_square).with(start_sq, board, pawn[:color], pawn[:type]).and_return(false)
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
      let!(:target_sq) { { file: 'b', rank: 3 } }
      let!(:start_file) { 'a' }
      let!(:board) { instance_double(Board) }

      context "when target square does not have an opponent chess piece" do
        it "returns false" do
          allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(nil)
          expect(judge.judge_capture(target_sq, start_file, ChessPiece::WH, board)).to be_falsey
        end
      end

      context "when target square has an opponent chess piece" do
        it "calls #check_target on the square of the moving pawn" do
          black_piece = { type: ChessPiece::PA, color: ChessPiece::BL }
          allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(black_piece)

          start_sq = { file: start_file, rank: target_sq[:rank] - 1 }
          white_pawn = { type: ChessPiece::PA, color: ChessPiece::WH }
          expect(judge).to receive(:check_target).with(start_sq, board, white_pawn)

          judge.judge_capture(target_sq, start_file, ChessPiece::WH, board)
        end
      end # context "when target square has an opponent chess piece"

      context "when target square has the player's own chess piece" do
        it "returns false" do
          player_piece = { type: ChessPiece::PA, color: ChessPiece::WH }
          allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(player_piece)

          expect(judge.judge_capture(target_sq, start_file, ChessPiece::WH, board)).to be_falsey
        end
      end # context "when target square has the player's own chess piece"
    end # context "when the pawn is white"

    context "when the pawn is black" do
      let!(:target_sq) { { file: 'b', rank: 6 } }
      let!(:start_file) { 'c' }
      let!(:board) { instance_double(Board) }

      context "when target square has the player's own chess piece" do
        it "returns false" do
          player_piece = { type: ChessPiece::PA, color: ChessPiece::BL }
          allow(board).to receive(:at).with(target_sq[:file], target_sq[:rank]).and_return(player_piece)

          expect(judge.judge_capture(target_sq, start_file, ChessPiece::BL, board)).to be_falsey
        end
      end
    end # context "when the pawn is black"
  end # describe '#judge_capture'

  
  describe '#judge_ep_capture' do
    subject(:judge) { described_class.new }

    context "when the pawn is white" do
      let!(:target_sq) { { file: 'b', rank: 6 } }
      let!(:start_file) { 'a' }
      let!(:ep_sq) { { file: 'b', rank: 5 } }
      let!(:board) { instance_double(Board) }
      let!(:black_pawn) { { type: ChessPiece::PA, color: ChessPiece::BL } }


      context "when opponent pawn is not on the en-passant square" do
        it "returns false" do
          allow(judge).to receive(:check_target).with(ep_sq, board, black_pawn).and_return(false)
          expect(judge.judge_ep_capture(target_sq, start_file, ChessPiece::WH, board)).to be_falsey
        end
      end
      
      context "when opponent pawn is on the en-passant square" do
        it "calls #judge_capture" do
          allow(judge).to receive(:check_target).with(ep_sq, board, black_pawn).and_return(true)
          expect(judge).to receive(:judge_capture).with(target_sq, start_file, ChessPiece::WH, board)

          judge.judge_ep_capture(target_sq, start_file, ChessPiece::WH, board)
        end
      end
    end # context "when the pawn is white"

    context "when the pawn is black" do
      let!(:target_sq) { { file: 'b', rank: 3 } }
      let!(:start_file) { 'a' }
      let!(:ep_sq) { { file: 'b', rank: 4 } }
      let!(:white_pawn) { { type: ChessPiece::PA, color: ChessPiece::WH } }
      let!(:board) { instance_double(Board) }

      context "when opponent pawn is not on the en-passant square" do
        it "returns false" do
          allow(judge).to receive(:check_target).with(ep_sq, board, white_pawn).and_return(false)
          expect(judge.judge_ep_capture(target_sq, start_file, ChessPiece::BL, board)).to be_falsey
        end
      end

      context "when opponent pawn is on the en-passant square" do
        it "calls #judge_capture" do
          allow(judge).to receive(:check_target).with(ep_sq, board, white_pawn).and_return(true)
          expect(judge).to receive(:judge_capture).with(target_sq, start_file, ChessPiece::BL, board)

          judge.judge_ep_capture(target_sq, start_file, ChessPiece::BL, board)
        end
      end
    end # context "when the pawn is black"
  end # describe '#judge_ep_capture'
end
