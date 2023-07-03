require './lib/move/rook_arbiter'
require './lib/board/board'
require './lib/standards/piece'

RSpec.describe RookArbiter do
  subject(:arbiter) { described_class.new }

  describe '#check_target' do
    context "when the target square on the board is empty" do
      let!(:file) { 'd' }
      let!(:rank) { 4 }
      let!(:board) { instance_double(Board) }

      before do
        allow(board).to receive(:at).with(file, rank).and_return(nil)
      end

      it "returns nil" do
        target = { file: file, rank: rank }
        piece = { type: Piece::RO, color: Piece::WH }
        expect(arbiter.check_target(board, target, piece)).to be_nil
      end
    end # context "when the target square on the board is empty"
  end # describe '#check_target'
end
