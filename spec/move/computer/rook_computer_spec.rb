require './lib/move/computer/rook_computer'


RSpec.describe RookComputer do
  describe '#compute_move' do
    context "when the starting file or rank is invalid" do
      subject(:computer) { described_class.new }

      it "returns nil" do
        target = { file: 'a', rank: 5 }
        start_file = 'z'
        expect(computer.compute_move(target, start_file)).to be_nil
      end
    end

    context "when the starting file is specified" do
      subject(:computer) { described_class.new }

      it "returns the one starting square" do
        target = { file: 'a', rank: 5 }
        start_file = 'd'
        exp_output = [{ file: 'd', rank: 5 }]
        expect(computer.compute_move(target, start_file)).to eq(exp_output)
      end
    end

    context "when the starting rank is specified" do
      subject(:computer) { described_class.new }

      it "returns the one starting square" do
        target = { file: 'a', rank: 5 }
        start_rank = 1
        exp_output = [{ file: 'a', rank: 1 }]
        expect(computer.compute_move(target, start_rank)).to eq(exp_output)
      end
    end
  end
end
