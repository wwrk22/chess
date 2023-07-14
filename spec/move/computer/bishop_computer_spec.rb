require './lib/move/computer/bishop_computer'


RSpec.describe BishopComputer do
  describe '#compute_move' do
    context "when the starting file is specified" do
      subject(:computer) { described_class.new }

      it "returns the two possible starting squares" do
        target = { file: 'd', rank: 4 }
        start_file = 'c'
        exp_output = [{ file: 'c', rank: 5 }, { file: 'c', rank: 3 }]
        expect(computer.compute_move(target, start_file)).to eq(exp_output)
      end
    end
  end
end
