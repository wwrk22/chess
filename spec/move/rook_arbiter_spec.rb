require './lib/move/rook_arbiter'
require './lib/board/board'
require './lib/standards/piece'

RSpec.describe RookArbiter do
  subject(:arbiter) { described_class.new }

  describe '#check_target' do
    let!(:file) { 'd' }
    let!(:rank) { 4 }
    let!(:target) { { file: file, rank: rank } }
    let!(:test_type) { Piece::RO }
    let!(:test_color) { Piece::WH }
    let!(:wh_rook) { { type: test_type, color: test_color } }
    let!(:board) { instance_double(Board) }

    context "when the target square on the board is empty" do
      before do
        allow(board).to receive(:at).with(file, rank).and_return(nil)
      end

      it "returns false" do
        expect(arbiter.check_target(board, target, wh_rook)).to eq(false)
      end
    end # context "when the target square on the board is empty"

    context "when the target square on the board is not empty" do
      context "when the chess piece on the square matches both type and color" do
        before do
          allow(board).to receive(:at).with(file, rank).and_return({ type: test_type, color: test_color })
        end

        it "returns true" do
          expect(arbiter.check_target(board, target, wh_rook)).to eq(true)
        end
      end

      context "when the chess piece on the square matches the type only" do
        before do
          allow(board).to receive(:at).with(file, rank).and_return({ type: test_type, color: Piece::BL })
        end

        it "returns false" do
          expect(arbiter.check_target(board, target, wh_rook)).to eq(false)
        end
      end

      context "when the chess piece on the square matches the color only" do
        before do
          allow(board).to receive(:at).with(file, rank).and_return({ type: Piece::PA, color: test_color })
        end

        it "returns false" do
          expect(arbiter.check_target(board, target, wh_rook)).to eq(false)
        end
      end

      context "when the chess piece on the square matches neither type nor color" do
        before do
          allow(board).to receive(:at).with(file, rank).and_return({ type: Piece::PA, color: Piece::BL })
        end

        it "returns false" do
          expect(arbiter.check_target(board, target, wh_rook)).to eq(false)
        end
      end
    end # context "when the target square on the board is not empty"
  end # describe '#check_target'
end
