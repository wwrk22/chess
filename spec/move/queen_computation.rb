require './lib/move/queen_computation'

RSpec.describe QueenComputation do
  context "when the move specifies the starting file" do
    it "returns the three possible starting squares on the given file" do
      data = { target: { f: 'd', r: 4 }, start_f: 'c' }
      exp_start_squares = [{ f: 'c', r: 5 }, { f: 'c', r: 4 }, { f: 'c', r: 3}]

      start_squares = QueenComputation::MOVE.call(data)
      expect(start_squares.difference(exp_start_squares)).to be_empty
    end
  end

  context "when the move specifies the starting rank" do
    it "returns the three possible starting squares on the given rank" do
      data = { target: { f: 'd', r: 4 }, start_r: 3 }
      exp_start_squares = [{ f: 'c', r: 3 }, { f: 'd', r: 3 }, { f: 'e', r: 3}]

      start_squares = QueenComputation::MOVE.call(data)
      expect(start_squares.difference(exp_start_squares)).to be_empty
    end
  end

  context "When the moves specifies neither the starting file nor rank" do
    it "returns all possible starting squares" do
      data = { target: { f: 'd', r: 4 } }
      exp_start_squares = [
        # rank line
        { f: 'a', r: 4 }, { f: 'b', r: 4 }, { f: 'c', r: 4 }, { f: 'e', r: 4 },
        { f: 'f', r: 4 }, { f: 'g', r: 4 }, { f: 'h', r: 4 },

        # file line
        { f: 'd', r: 1 }, { f: 'd', r: 2 }, { f: 'd', r: 3 }, { f: 'd', r: 5 },
        { f: 'd', r: 6 }, { f: 'd', r: 7 }, { f: 'd', r: 8 },

        # diagonal a
        { f: 'c', r: 5 }, { f: 'b', r: 6 }, { f: 'a', r: 7 },
        { f: 'e', r: 3 }, { f: 'f', r: 2 }, { f: 'g', r: 1 },

        # diagonal b
        { f: 'c', r: 3 }, { f: 'b', r: 2 }, { f: 'a', r: 1 },
        { f: 'e', r: 5 }, { f: 'f', r: 6 }, { f: 'g', r: 7 }, { f: 'h', r: 8 }
      ]

      start_squares = QueenComputation::MOVE.call(data)
      expect(start_squares.difference(exp_start_squares)).to be_empty
    end
  end
end
