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
end
