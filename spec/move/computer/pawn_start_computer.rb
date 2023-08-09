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

      allow(board).to receive(:at).with(expected_start).and_return(white_pawn)

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


  describe '#compute_start' do
    subject(:computer) { described_class.new }

    let!(:move) { instance_double(Move) }
    let!(:board) { instance_double(Board) }

    before do
      allow(move).to receive(:capture).and_return false
    end

    context "when the pawn is white" do
      let(:white_pawn) { ChessPiece.new(pawn, white) }

      before do
        allow(move).to receive(:piece).and_return(white_pawn)
      end

      context "when the move is a single" do
        let(:target_square) { { file: 'a', rank: 3 } }
        let!(:first_square) { { file: target_square[:file], rank: target_square[:rank] - 1 } }

        before do
          allow(move).to receive(:target).and_return(target_square)
        end

        context "when the first square has the moving pawn" do
          it "returns the square" do
            allow(board).to receive(:at).with(first_square).and_return white_pawn
     
            expected = { file: 'a', rank: 2 }
            result = computer.compute_start(move, board)
            expect(result).to eq(expected)
          end
        end

        context "when the first square does not have the moving pawn" do
          it "returns nil" do
            allow(board).to receive(:at).with(first_square).and_return nil
     
            result = computer.compute_start(move, board)
            expect(result).to be_nil
          end
        end
      end # context "when the move is a single"

      context "when the move is a double" do
        let(:target_square) { { file: 'a', rank: 4 } }
        let!(:first_square) { { file: target_square[:file], rank: target_square[:rank] - 1 } }
        let!(:second_square) { { file: target_square[:file], rank: target_square[:rank] - 2 } }

        before do
          allow(move).to receive(:target).and_return(target_square)
        end

        context "when the second square has the moving pawn" do
          it "returns the square" do
            allow(board).to receive(:at).with(first_square).and_return nil
            allow(board).to receive(:at).with(second_square).and_return white_pawn
     
            expected = { file: 'a', rank: 2 }
            result = computer.compute_start(move, board)
            expect(result).to eq(expected)
          end
        end

        context "when the second square does not have the moving pawn" do
          it "returns nil" do
            allow(board).to receive(:at).with(first_square).and_return nil
            allow(board).to receive(:at).with(second_square).and_return nil
     
            result = computer.compute_start(move, board)
            expect(result).to be_nil
          end
        end
      end # context "when the move is a double"
    end # context "when the pawn is white"

    context "when the pawn is black" do
      let!(:black_pawn) { ChessPiece.new(pawn, black) }

      before do
        allow(move).to receive(:piece).and_return(black_pawn)
      end

      context "when the move is a single" do
        let(:target_square) { { file: 'a', rank: 6 } }
        let!(:first_square) { { file: target_square[:file], rank: target_square[:rank] + 1 } }
        let!(:second_square) { { file: target_square[:file], rank: target_square[:rank] + 2 } }

        before do
          allow(move).to receive(:target).and_return(target_square)
        end

        context "when the first square has the moving pawn" do
          it "returns the square" do
            allow(board).to receive(:at).with(first_square).and_return black_pawn
     
            expected = { file: 'a', rank: 7 }
            result = computer.compute_start(move, board)
            expect(result).to eq(expected)
          end
        end

        context "when the first square does not have the moving pawn" do
          it "returns nil" do
            allow(board).to receive(:at).with(first_square).and_return nil
     
            result = computer.compute_start(move, board)
            expect(result).to be_nil
          end
        end
      end # context "when the move is a single"

      context "when the move is a double" do
        let(:target_square) { { file: 'a', rank: 5 } }
        let!(:first_square) { { file: target_square[:file], rank: target_square[:rank] + 1 } }
        let!(:second_square) { { file: target_square[:file], rank: target_square[:rank] + 2 } }

        before do
          allow(move).to receive(:target).and_return(target_square)
        end

        context "when the second square has the moving pawn" do
          it "returns the square" do
            allow(board).to receive(:at).with(first_square).and_return nil
            allow(board).to receive(:at).with(second_square).and_return black_pawn
     
            expected = { file: 'a', rank: 7 }
            result = computer.compute_start(move, board)
            expect(result).to eq(expected)
          end
        end

        context "when the second square does not have the moving pawn" do
          it "returns nil" do
            allow(board).to receive(:at).with(first_square).and_return nil
            allow(board).to receive(:at).with(second_square).and_return nil
     
            result = computer.compute_start(move, board)
            expect(result).to be_nil
          end
        end
      end # context "when the move is a double"
    end # context "when the pawn is black"
  end # describe '#compute_start'
end
