require './lib/board/board'
require './lib/move/computer/pawn_start_computer'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'
require './lib/move/move'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe PawnStartComputer do
  describe '#compute_capture_start' do
    context "when pawn is white" do
      subject(:computer) { described_class.new }

      it "returns a square whose rank is one less than the target" do
        target_square = { file: 'a', rank: 3 }
        expected_start = { file: 'b', rank: 2 }
        move = instance_double(Move)
        allow(move).to receive(:target).and_return(target_square)

        computed_start = computer.compute_capture_start(white, expected_start[:file], target_square)
        expect(computed_start).to eq(expected_start)
      end
    end

    context "when pawn is black" do
      subject(:computer) { described_class.new }

      it "returns a square whose rank is one more than the target" do
        target_square = { file: 'a', rank: 6 }
        expected_start = { file: 'b', rank: 7 }
        move = instance_double(Move)
        allow(move).to receive(:target).and_return(target_square)

        computed_start = computer.compute_capture_start(black, expected_start[:file], target_square)
        expect(computed_start).to eq(expected_start)
      end
    end # context "when pawn is black"
  end # describe '#compute_capture'


  describe '#compute_capture' do
    subject(:computer) { described_class.new }

    it "returns a boolean to indicate whether the starting square could be determined" do
      move = instance_double(Move)
      board = instance_double(Board)
      white_pawn = instance_double(ChessPiece)
      expected_start = { file: 'b', rank: 2 }

      allow(white_pawn).to receive(:type).and_return(pawn)
      allow(white_pawn).to receive(:color).and_return(white)

      allow(move).to receive(:piece).and_return(white_pawn)
      allow(move).to receive(:start_coordinate).and_return('b')
      allow(move).to receive(:target).and_return({ file: 'a', rank: 3 })

      allow(board).to receive(:at).with(expected_start[:file], expected_start[:rank]).and_return(white_pawn)

      result = computer.compute_capture(move, board)
      expect(result).to eq(expected_start)
    end
  end # describe '#compute_capture'


  describe '#compute_single' do
    subject(:computer) { described_class.new }

    context "when the move is for white" do
      it "returns the square directly below the target square" do
        move = instance_double(Move)
        target_square = { file: 'a', rank: 3 }
        white_pawn = instance_double(ChessPiece)

        allow(white_pawn).to receive(:color).and_return(white)
        allow(move).to receive(:target).and_return(target_square)
        allow(move).to receive(:piece).and_return(white_pawn)

        expected = { file: 'a', rank: 2 }
        result = computer.compute_single(move)
        expect(result).to eq(expected)
      end
    end

    context "when the move is for black" do
      it "returns the square directly below the target square" do
        move = instance_double(Move)
        target_square = { file: 'a', rank: 6 }
        black_pawn = instance_double(ChessPiece)

        allow(black_pawn).to receive(:color).and_return(black)
        allow(move).to receive(:target).and_return(target_square)
        allow(move).to receive(:piece).and_return(black_pawn)

        expected = { file: 'a', rank: 7 }
        result = computer.compute_single(move)
        expect(result).to eq(expected)
      end
    end
  end # describe '#compute_move'
end
