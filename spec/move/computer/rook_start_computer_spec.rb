require './lib/move/computer/rook_start_computer'
require './lib/piece/rook_specs'
require './lib/move/move'
require './lib/board/board'


RSpec.describe RookStartComputer do
  describe '#compute_move_old' do
    context "when the starting file or rank is invalid" do
      subject(:computer) { described_class.new }

      it "returns nil" do
        target = { file: 'a', rank: 5 }
        start_file = 'z'
        expect(computer.compute_move_old(target, start_file)).to be_nil
      end
    end

    context "when the starting file is specified" do
      subject(:computer) { described_class.new }

      it "returns the one starting square" do
        target = { file: 'a', rank: 5 }
        start_file = 'd'
        exp_output = [{ file: 'd', rank: 5 }]
        expect(computer.compute_move_old(target, start_file)).to eq(exp_output)
      end
    end

    context "when the starting rank is specified" do
      subject(:computer) { described_class.new }

      it "returns the one starting square" do
        target = { file: 'a', rank: 5 }
        start_rank = 1
        exp_output = [{ file: 'a', rank: 1 }]
        expect(computer.compute_move_old(target, start_rank)).to eq(exp_output)
      end
    end
  end # describe '#compute_move_old'


  describe '#compute_move' do
    subject(:computer) { described_class.new }

    it "returns the starting square if it exists" do
      move = instance_double(Move)
      board = instance_double(Board)
      check_multiple_paths_args = [move, board, RookSpecs::DIRECTIONS]

      expect(computer).to receive(:check_multiple_paths).with(*check_multiple_paths_args)
      computer.compute_move(move, board)
    end
  end # describe '#compute_move'
end
