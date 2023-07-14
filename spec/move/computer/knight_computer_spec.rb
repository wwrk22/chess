require './lib/move/computer/knight_computer'


RSpec.describe KnightComputer do
  describe '#compute_move' do
    subject(:computer) { described_class.new }

    it "returns all of the at most eight possible starting squares" do
      target = { file: 'c', rank: 3 }
      exp_output = [
        { file: 'd', rank: 5 }, { file: 'e', rank: 4 },
        { file: 'e', rank: 2 }, { file: 'd', rank: 1 },
        { file: 'b', rank: 1 }, { file: 'a', rank: 2 },
        { file: 'a', rank: 4 }, { file: 'b', rank: 5 }
      ]
      expect(computer.compute_move(target)).to eq(exp_output)
    end
  end # describe '#compute_non_capture'

  describe '#prune_squares' do
    context "when there are no out-of-bounds squares" do
      subject(:computer) { described_class.new }

      it "returns the same array of squares" do
        squares = [{ file: 'a', rank: 1 }]
        expect(computer.prune_squares(squares)).to eq(squares)
      end
    end

    context "when there is an out-of-bounds square" do
      context "when there is a square with out-of-bounds file" do
        subject(:computer) { described_class.new }

        it "removes the out-of-bounds square" do
          squares = [{ file: 'a', rank: 1 }, { file: 'q', rank: 1 }]
          exp_output = [{ file: 'a', rank: 1 }]
          expect(computer.prune_squares(squares)).to eq(exp_output)
        end
      end

      context "when there is a square with out-of-bounds rank" do
        subject(:computer) { described_class.new }

        it "removes the out-of-bounds square" do
          squares = [{ file: 'a', rank: 1 }, { file: 'b', rank: 9 }]
          exp_output = [{ file: 'a', rank: 1 }]
          expect(computer.prune_squares(squares)).to eq(exp_output)
        end
      end
    end
  end
end
