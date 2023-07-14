require './lib/move/computer/king_computer'

RSpec.describe KingComputer do
  describe '#compute_move' do
    context "when the target square is not on an edge of the board" do
      subject(:computer) { described_class.new }

      it "returns eight possible starting squares" do
        target = { file: 'e', rank: 3 }
        exp_output = [
          { file: 'e', rank: 4 }, { file: 'f', rank: 4 }, { file: 'f', rank: 3 },
          { file: 'f', rank: 2 }, { file: 'e', rank: 2 }, { file: 'd', rank: 2 },
          { file: 'd', rank: 3 }, { file: 'd', rank: 4 }
        ]
        result = computer.compute_move(target)
        diff = exp_output.difference(result)
        expect(diff).to be_empty
      end
    end
  end
end
