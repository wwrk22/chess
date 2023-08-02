require 'support/matchers/chess_piece'
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


  describe '#calculate_limit' do
    subject(:computer) { described_class.new }

    context "when the target square rank is four and the pawn is white" do
      it "returns two" do
        result = computer.calculate_limit(white, 4)
        expect(result).to eq(2)
      end
    end

    context "when the target square rank is five and the pawn is black" do
      it "returns two" do
        result = computer.calculate_limit(black, 5)
        expect(result).to eq(2)
      end
    end

    context "when the target square rank cannot be a double move" do
      it "returns one" do
        result = computer.calculate_limit(white, 3)
        expect(result).to eq(1)
      end
    end
  end # describe '#calculate_limit'
end
