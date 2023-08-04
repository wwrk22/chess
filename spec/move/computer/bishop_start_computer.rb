require './lib/move/computer/bishop_start_computer'
require './lib/move/move'
require './lib/board/board'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe BishopStartComputer do
  describe '#compute_move' do
    subject(:computer) { described_class.new }

    let!(:move) { instance_double(Move) }
    let!(:board) { instance_double(Board) }

    context "when the move has a start coordinate" do
      it "sends compute_with_start_coordinate" do
        allow(move).to receive(:start_coordinate).and_return 'a'

        expect(computer).to receive(:compute_with_start_coordinate)
        computer.compute_move(move, board)
      end
    end

    context "when the move does not have a start coordinate" do
      it "sends check_multiple_paths" do
        allow(move).to receive(:start_coordinate).and_return nil

        expect(computer).to receive(:check_multiple_paths)
        computer.compute_move(move, board)
      end
    end
  end # describe '#compute_move'

  
  describe '#compute_with_file' do
    subject(:computer) { described_class.new }

    context "when two starting squares are possible" do
      it "returns the two squares on the starting file that the bishop can move from" do
        target_square = { file: 'e', rank: 3 }
        start_file = 'c'
        expected = [{ file: start_file, rank: 1 }, { file: start_file, rank: 5 }]

        starting_squares = computer.compute_with_file(target_square, start_file)

        result = expected.difference(starting_squares).none? &&
                 starting_squares.difference(expected).none?
        expect(result).to be_truthy
      end
    end

    context "when only one starting square is possible" do
      it "returns the one square on the starting file that the bishop can move from" do
        target_square = { file: 'c', rank: 1 }
        start_file = 'b'
        expected = [{ file: start_file, rank: 2 }]

        starting_square = computer.compute_with_file(target_square, start_file)

        result = expected.difference(starting_square).none? &&
                 starting_square.difference(expected).none?
        expect(result).to be_truthy
      end
    end
  end # describe '#compute_with_file'


  describe '#compute_with_rank' do
    subject(:computer) { described_class.new }

    context "when two starting squares are possible" do
      it "returns the two squares on the starting rank that the bishop can move from" do
        target_square = { file: 'c', rank: 3 }
        start_rank = 5
        expected = [{ file: 'a', rank: start_rank }, { file: 'e', rank: start_rank }]

        starting_squares = computer.compute_with_rank(target_square, start_rank)

        result = expected.difference(starting_squares).none? &&
                 starting_squares.difference(expected).none?

        expect(result).to be_truthy
      end
    end

    context "when only one starting square is possible" do
      it "returns the one square on the starting rank that the bishop can move from" do
        target_square = { file: 'a', rank: 1 }
        start_rank = 2
        expected = [{ file: 'b', rank: start_rank }]

        starting_squares = computer.compute_with_rank(target_square, start_rank)

        result = expected.difference(starting_squares).none? &&
                 starting_squares.difference(expected).none?

        expect(result).to be_truthy
      end
    end
  end # describe '#compute_with_rank'


  describe '#compute_with_start_coordinate' do
    subject(:computer) { described_class.new }

    context "when the move uses a starting file" do
      let!(:board) { instance_double(Board) }
      let!(:move) { instance_double(Move) }
      let!(:moving_bishop) { ChessPiece.new(bishop, white) }
      let!(:start_a) { { file: 'c', rank: 1 } }
      let!(:start_b) { { file: 'c', rank: 7 } }

      before do
        allow(move).to receive(:start_coordinate).and_return 'c'
        allow(move).to receive(:target).and_return({ file: 'f', rank: 4 })
      end

      context "when there are no valid starting squares" do
        it "returns nil" do
          allow(computer).to receive(:valid_start?).with(start_a, board).and_return false
          allow(computer).to receive(:valid_start?).with(start_b, board).and_return false

          result = computer.compute_with_start_coordinate(move, board)
          expect(result).to be_nil
        end
      end

      context "when there is one valid starting square" do
        it "returns the one square" do
          allow(computer).to receive(:valid_start?).with(start_a, board).and_return false
          allow(computer).to receive(:valid_start?).with(start_b, board).and_return true

          result = computer.compute_with_start_coordinate(move, board)
          expect(result).to eq(start_b)
        end
      end

      context "when there are two valid starting squares" do
        it "returns nil" do
          allow(computer).to receive(:valid_start?).with(start_a, board).and_return true
          allow(computer).to receive(:valid_start?).with(start_b, board).and_return true

          result = computer.compute_with_start_coordinate(move, board)
          expect(result).to be_nil
        end
      end
    end

    context "when the move uses a starting rank" do
      context "when there are no valid starting squares" do
      end

      context "when there is one valid starting square" do
      end

      context "when there are two valid starting squares" do
      end
    end
  end # describe '#compute_with_start_coordinate'
end
