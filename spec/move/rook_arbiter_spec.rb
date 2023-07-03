require './lib/move/rook_arbiter'
require './lib/board/board'
require './lib/standards/piece'

RSpec.describe RookArbiter do
  subject(:arbiter) { described_class.new }

  describe '#check_target' do
    let!(:file) { 'd' }
    let!(:rank) { 4 }
    let!(:board) { instance_double(Board) }

    context "when the target square on the board is empty" do
      before do
        allow(board).to receive(:at).with(file, rank).and_return(nil)
      end

      it "returns false" do
        target = { file: file, rank: rank }
        piece = { type: Piece::RO, color: Piece::WH }
        expect(arbiter.check_target(board, target, piece)).to eq(false)
      end
    end # context "when the target square on the board is empty"

    context "when the target square on the board is not empty" do
      context "when the chess piece on the square matches the type only" do
      end

      context "when the chess piece on the square matches the color only" do
      end

      context "when the chess piece on the square matches both type and color" do
      end

      context "when the chess piece on the square matches neither type nor color" do
        before do
          allow(board).to receive(:at).with(file, rank).and_return({ type: Piece::PA, color: Piece::BL })
        end

        it "returns false" do
          target = { file: file, rank: rank }
          piece = { type: Piece::RO, color: Piece::WH }
          expect(arbiter.check_target(board, target, piece)).to eq(false)
        end
      end
    end # context "when the target square on the board is not empty"
  end # describe '#check_target'
end
