require './lib/move/computer/queen_computer'


RSpec.describe QueenComputer do
  describe '#compute_move' do
    context "when the starting file is given" do
      subject(:computer) { described_class.new }

      it "returns the at most three possible starting squares" do
        target = { file: 'd', rank: 4 }
        start_file = 'b'
        exp_output = [{ file: 'b', rank: 6 }, { file: 'b', rank: 4 }, { file: 'b', rank: 2 }]
        result = computer.compute_move(target, start_file)
        diff = exp_output.difference(result)
        expect(diff).to be_empty
        expect(result.size).to eq(exp_output.size)
      end
    end

    context "when the starting rank is given" do
      subject(:computer) { described_class.new }

      it "returns the at most three possible starting squares" do
        target = { file: 'd', rank: 4 }
        start_rank = 2
        exp_output = [{ file: 'b', rank: 2 }, { file: 'd', rank: 2 }, { file: 'f', rank: 2 }]
        result = computer.compute_move(target, start_rank)
        diff = exp_output.difference(result)
        expect(diff).to be_empty
        expect(result.size).to eq(exp_output.size)
      end
    end
  end
end
