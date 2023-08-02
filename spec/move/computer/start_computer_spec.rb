require './lib/move/computer/start_computer'
require './lib/piece/piece_specs'
require './lib/board/board'
require './lib/piece/chess_piece'
require './lib/move/move'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe StartComputer do
  describe '#check_start' do
    subject(:computer) { described_class.new }

    it "checks the board to see if the chess piece is on the starting square" do
      board = instance_double(Board)
      start_square = { file: 'a', rank: 1 }
      white_rook = instance_double(ChessPiece)

      allow(board).to receive(:at).with(start_square[:file], start_square[:rank]).and_return(white_rook)

      allow(white_rook).to receive(:type).and_return(rook)
      allow(white_rook).to receive(:color).and_return(white)

      result = computer.check_start(start_square, white_rook, board)
      expect(result).to be_truthy
    end
  end # describe '#check_start'


  describe '#check_path' do
    subject(:computer) { described_class.new }

    let(:move) { instance_double(Move) }
    let(:board) { instance_double(Board) }
    let(:white_rook) { ChessPiece.new(rook, white) }
    let(:direction) { { file: 0, rank: -1 } }

    before do
      allow(move).to receive(:target).and_return({ file: 'a', rank: 3 })
      allow(move).to receive(:piece).and_return(white_rook)
    end

    context "when the piece is on the path and can get to the target square" do
      it "returns the square that the piece is on" do
        allow(board).to receive(:at).with('a', 2).and_return nil
        allow(board).to receive(:at).with('a', 1).and_return white_rook

        result = computer.check_path(move, board, direction)
        expected = { file: 'a', rank: 1 }
        expect(result).to eq(expected)
      end
    end

    context "when the piece is on the path but cannot get to the target square" do
      it "returns nil" do
        allow(board).to receive(:at).with('a', 2).and_return ChessPiece.new(pawn, white)
        
        result = computer.check_path(move, board, direction)
        expect(result).to be_nil
      end
    end

    context "when the piece is not on the path" do
      it "returns nil" do
        allow(board).to receive(:at).with('a', 2).and_return nil
        allow(board).to receive(:at).with('a', 1).and_return nil
        
        result = computer.check_path(move, board, direction)
        expect(result).to be_nil
      end
    end
  end # describe '#check_path'
end
