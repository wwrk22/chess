require './lib/move/computer/knight_computer'


RSpec.describe KnightComputer do
  describe '#compute_non_capture' do
    subject(:computer) { described_class.new }

    it "returns all of the at most eight possible starting squares" do
      target = { file: 'c', rank: 3 }
      exp_output = [
        { file: 'd', rank: 5 }, { file: 'e', rank: 4 },
        { file: 'e', rank: 2 }, { file: 'd', rank: 1 },
        { file: 'b', rank: 1 }, { file: 'a', rank: 2 },
        { file: 'a', rank: 4 }, { file: 'b', rank: 5 }
      ]
      expect(computer.compute_non_capture(target)).to eq(exp_output)
    end
  end # describe '#compute_non_capture'
end
