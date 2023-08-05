require './lib/move/performer/move_performer'
require './lib/move/move'
require './lib/board/board'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe MovePerformer do
  describe '#do_move' do
    subject(:performer) { described_class.new }
    
    let!(:move) { instance_double(Move) }
    let!(:board) { instance_double(Board) }

    before do
      allow(move).to receive(:target).and_return({ file: 'a', rank: 3 })
      allow(move).to receive(:piece).and_return(ChessPiece.new(pawn, white))
      allow(move).to receive(:start).and_return({ file: 'a', rank: 2})
    end

    context "when the target square is empty" do
      it "returns true" do
        allow(board).to receive(:at_sq).with(move.target).and_return nil
        allow(board).to receive(:set)

        result = performer.do_move(move, board)
        expect(result).to be_truthy
      end
    end

    context "when the target square is not empty" do
      it "returns false" do
        allow(board).to receive(:at_sq).with(move.target).and_return ChessPiece.new(pawn, black)
        allow(board).to receive(:set)

        result = performer.do_move(move, board)
        expect(result).to be_falsey
      end
    end
  end # describe '#do_move'
end
