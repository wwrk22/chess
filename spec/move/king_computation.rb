require './lib/move/king_computation'

RSpec.describe KingComputation do
  context "when the target square is not on an edge of the board" do
    it "returns all nine starting squares" do
      data = { target: { f: 'd', r: 4 } }
      exp_start_squares = [
        { f: 'c', r: 5 }, { f: 'd', r: 5 }, { f: 'e', r: 5 },
        { f: 'c', r: 4 }, { f: 'e', r: 4 },
        { f: 'c', r: 3 }, { f: 'd', r: 3 }, { f: 'e', r: 3 }
      ]

      start_squares = KingComputation::MOVE.call(data)
      expect(exp_start_squares.difference(start_squares)).to be_empty
    end
  end

  context "when the target square is on an edge of the board" do
    context "when the target square is on a corner" do
      it "returns the three starting squares" do
        data = { target: { f: 'a', r: 1 } }
        exp_start_squares = [{ f: 'a', r: 2 }, { f: 'b', r: 2 }, { f: 'b', r: 1 }]

        start_squares = KingComputation::MOVE.call(data)
        expect(exp_start_squares.difference(start_squares)).to be_empty
      end
    end

    context "when the target square is not on a corner" do
      it "returns the five starting squares" do
        data = { target: { f: 'c', r: 1 } }
        exp_start_squares = [{ f: 'b', r: 1 }, { f: 'b', r: 2 },
                             { f: 'c', r: 2 },
                             { f: 'd', r: 2 }, { f: 'd', r: 1}]

        start_squares = KingComputation::MOVE.call(data)
        expect(exp_start_squares.difference(start_squares)).to be_empty
      end
    end
  end
end
