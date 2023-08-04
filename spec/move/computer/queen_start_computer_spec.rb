require './lib/move/computer/queen_start_computer'
require './lib/piece/queen_specs'
require './lib/move/move'
require './lib/board/board'


RSpec.describe QueenStartComputer do
  describe '#compute_move' do
    subject(:computer) { described_class.new }

    let!(:move) { instance_double(Move) }
    let!(:board) { instance_double(Board) }

    context "when the move has a starting coordinate" do
      it "sends compute_with_start_coordinate" do
        allow(move).to receive(:start_coordinate).and_return 'a'

        expect(computer).to receive(:compute_with_start_coordinate)
        computer.compute_move(move, board)
      end
    end

    context "when the move does not have a starting coordinate" do
      it "sends check_multiple_paths" do
        allow(move).to receive(:start_coordinate).and_return nil

        expect(computer).to receive(:check_multiple_paths)
        computer.compute_move(move, board)
      end
    end
  end # describe '#compute_move'


  describe '#compute_start_ranks' do
    subject(:computer) { described_class.new }

    it "returns an array of three ranks computed with the distance between target and starting file" do
      expected = [3, 4, 5]

      result = computer.compute_start_ranks({ file: 'd', rank: 4 }, 'c')
      expect(result).to eq(expected)
    end
  end # describe '#compute_start_ranks'


  describe '#compute_start_files' do
    subject(:computer) { described_class.new }

    it "returns an array of three files computed with the distance between target and starting rank" do
      expected = ['c', 'd', 'e']

      result = computer.compute_start_files({ file: 'd', rank: 4 }, 3)
      expect(result).to eq(expected)
    end
  end # describe '#compute_start_ranks'

  
  describe '#compute_starts_with_file' do
    subject(:computer) { described_class.new }

    it "maps a computed set of ranks to only valid squares with those ranks" do
      expected = [{ file: 'c', rank: 3 }, { file: 'c', rank: 4 }, { file: 'c', rank: 5 }]

      result = computer.compute_starts_with_file({ file: 'd', rank: 4 }, 'c')
      expect(result).to eq(expected)
    end
  end # describe '#compute_starts_with_file'


  describe '#compute_starts_with_rank' do
    subject(:computer) { described_class.new }

    it "maps a computed set of ranks to only valid squares with those files" do
      expected = [{ file: 'a', rank: 1 }, { file: 'b', rank: 1 }, { file: 'c', rank: 1 }]

      result = computer.compute_starts_with_rank({ file: 'b', rank: 2 }, 1)
      expect(result).to eq(expected)
    end
  end # describe '#compute_starts_with_rank'


  describe '#start_off_target_axes' do
    subject(:computer) { described_class.new }

    let!(:move) { instance_double(Move) }
    let!(:board) { instance_double(Board) }

    context "when exactly one possible starting square is valid" do
      it "returns that square" do
        valid_start = { file: 'a', rank: 1 }
        invalid_start_a = { file: 'b', rank: 1 }
        invalid_start_b = { file: 'c', rank: 1 }

        allow(move).to receive(:target).and_return({ file: 'b', rank: 2 })
        allow(move).to receive(:start_coordinate).and_return 1

        allow(computer).to receive(:valid_start?).with(valid_start, move, board).and_return true
        allow(computer).to receive(:valid_start?).with(invalid_start_a, move, board).and_return false
        allow(computer).to receive(:valid_start?).with(invalid_start_b, move, board).and_return false

        result = computer.start_off_target_axes(move, board)
        expect(result).to eq(valid_start)
      end
    end

    context "when more than one possible starting square is valid" do
      it "returns that square" do
        valid_start_a = { file: 'a', rank: 1 }
        valid_start_b = { file: 'b', rank: 1 }
        invalid_start = { file: 'c', rank: 1 }

        allow(move).to receive(:target).and_return({ file: 'b', rank: 2 })
        allow(move).to receive(:start_coordinate).and_return 1

        allow(computer).to receive(:valid_start?).with(valid_start_a, move, board).and_return true
        allow(computer).to receive(:valid_start?).with(valid_start_b, move, board).and_return true
        allow(computer).to receive(:valid_start?).with(invalid_start, move, board).and_return false

        result = computer.start_off_target_axes(move, board)
        expect(result).to be_nil
      end
    end # context "when more than one possible starting square is valid"
  end # describe '#start_off_target_axes'
end
