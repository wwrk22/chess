require './lib/move/computer/rook_start_computer'
require './lib/piece/rook'
require './lib/piece/rook_specs'
require './lib/piece/piece_specs'
require './lib/move/move'
require './lib/board/board'
require_relative './test_moves/rook'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
  cfg.include TestRookMoves
end

RSpec.describe RookStartComputer do

  describe '#compute_start' do
    subject(:computer) { described_class.new }

    let!(:move) { instance_double(Move) }
    let!(:board) { instance_double(Board) }

    before do
      allow(move).to receive(:piece).and_return Rook.new(white)
      allow(move).to receive(:target).and_return({ file: 'a', rank: 1 })
    end

    context "when there is no start coordinate" do
      it "sends check_multiple_paths" do
        allow(move).to receive(:start_coordinate).and_return nil

        check_multiple_paths_args = [move, board, RookSpecs::DIRECTIONS]
        expect(computer).to receive(:check_multiple_paths).with(*check_multiple_paths_args)
        computer.compute_start(move, board)
      end
    end

    context "when there is a start coordinate" do
      it "sends compute_with_start_coordinate" do
        allow(move).to receive(:start_coordinate).and_return 'a'

        expect(computer).to receive(:compute_with_start_coordinate).with(move, board)
        computer.compute_start(move, board)
      end
    end

    context "when computing the start for all possible moves" do
      it "returns the correct starting square for all" do
        b = Board.new

        result = legal_rook_moves.all? do |move|
          b.clear
          b.set(move[:exp_start], Rook.new(white))

          computer.compute_start(move[:move], b) == move[:exp_start]
        end

        expect(result).to eq(true)
      end
    end # context "when computing the start for all possible moves"
  end # describe '#compute_start'


  describe '#start_off_target_axes' do
    subject(:computer) { described_class.new }

    let!(:move) { instance_double(Move) }
    let!(:board) { Board.new }
    let!(:moving_rook) { Rook.new(white) }
    let!(:target_square) { { file: 'd', rank: 4 } }

    before do
      allow(move).to receive(:target).and_return target_square
      allow(move).to receive(:piece).and_return moving_rook
    end

    context "when the starting coordinate is a file" do
      let!(:start_coordinate) { 'a' }
      let!(:expected) { { file: 'a', rank: 4 } }

      before do
        allow(move).to receive(:start_coordinate).and_return start_coordinate
      end

      context "when the starting square has the moving rook" do
        it "returns a square with that file and the same rank as the target square" do 
          board.set(expected, moving_rook)

          result = computer.start_off_target_axes(move, board)
          expect(result).to eq(expected)
        end
      end

      context "when the starting square does not have the moving rook" do
        it "returns nil" do
          result = computer.start_off_target_axes(move, board)
          expect(result).to be_nil
        end
      end
    end # context "when the starting coordinate is a file"

    context "when the starting coordinate is a rank" do
      let!(:start_coordinate) { 2 }
      let!(:expected) { { file: 'd', rank: 2 } }

      before do
        allow(move).to receive(:start_coordinate).and_return start_coordinate
      end

      context "when the starting square has the moving rook" do
        it "returns a square with that rank and the same file as the target square" do
          board.set(expected, moving_rook)

          result = computer.start_off_target_axes(move, board)
          expect(result).to eq(expected)
        end
      end

      context "when the starting square does not have the moving rook" do
        it "returns nil" do
          result = computer.start_off_target_axes(move, board)
          expect(result).to be_nil
        end
      end
    end # context "when the starting coordinate is a rank"
  end # describe '#start_off_target_axes'


  describe '#start_on_target_axes' do
    subject(:computer) { described_class.new }

    let!(:board) { instance_double(Board) }
    let!(:move) { instance_double(Move) }

    before do
      allow(move).to receive(:piece).and_return Rook.new(white)
      allow(move).to receive(:target).and_return({ file: 'a', rank: 4 })
    end

    context "when the start coordinate is the target square file" do
      it "sends #check_multiple_paths with the two directions along the file" do
        allow(move).to receive(:start_coordinate).and_return(move.target[:file])

        directions = [{ file: 0, rank: 1 }, { file: 0, rank: -1 }]
        expect(computer).to receive(:check_multiple_paths).with(move, board, directions)

        computer.start_on_target_axes(move, board)
      end
    end

    context "when the start coordinate is the target square rank" do
      it "sends #check_multiple_paths with the two directions along the file" do
        allow(move).to receive(:start_coordinate).and_return(move.target[:rank])

        directions = [{ file: 1, rank: 0 }, { file: -1, rank: 0 }]
        expect(computer).to receive(:check_multiple_paths).with(move, board, directions)

        computer.start_on_target_axes(move, board)
      end
    end
  end # describe '#start_on_target_axes'


  describe '#compute_with_start_coordinate' do
    subject(:computer) { described_class.new }
    
    let!(:move) { instance_double(Move) }
    let!(:board) { instance_double(Board) }

    before do
      allow(move).to receive(:target).and_return({ file: 'a', rank: 1 })
    end

    context "when the start coordinate is on the target square's axes" do
      it "sends start_on_target_axes" do
        allow(move).to receive(:start_coordinate).and_return 'a'

        expect(computer).to receive(:start_on_target_axes).with(move, board)
        computer.compute_with_start_coordinate(move, board)
      end
    end

    context "when the start coordinate is not on the target square's axes" do
      it "sends start_off_target_axes" do
        allow(move).to receive(:start_coordinate).and_return 'b'

        expect(computer).to receive(:start_off_target_axes).with(move, board)
        computer.compute_with_start_coordinate(move, board)
      end
    end
  end # describe '#compute_with_start_coordinate'
end
