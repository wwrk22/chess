require './lib/move/knight_computation'
require './spec/support/computation_helpers'

RSpec.configure do |cfg|
  cfg.include ComputationHelpers
end

RSpec.describe KnightComputation do
  context "when the move has a start file" do
    it "returns the two possible starting squares of the start file" do
      data = { target: { f: 'c', r: 3 }, start_f: 'b' }
      exp_start_squares = [{ f: 'b', r: 5}, { f: 'b', r: 1 }]

      start_squares = KnightComputation::MOVE.call(data)
      expect(start_squares).to eq(exp_start_squares)
    end
  end

  context "when the move has a start rank" do
    it "returns the two possible starting squares of the start rank" do
      data = { target: { f: 'c', r: 3 }, start_r: 4 }
      exp_start_squares = [{ f: 'a', r: 4 }, { f: 'e', r: 4 }]

      start_squares = KnightComputation::MOVE.call(data)
      expect(start_squares).to eq(exp_start_squares)
    end
  end


  context "when the move does not have a start file or rank" do
    it "returns all of the possible starting squares" do
      data = { target: { f: 'c', r: 3 } }
      exp_start_squares = [{ f: 'd', r: 5 }, { f: 'e', r: 4 },
                           { f: 'e', r: 2 }, { f: 'd', r: 1 },
                           { f: 'b', r: 1 }, { f: 'a', r: 2 },
                           { f: 'a', r: 4 }, { f: 'b', r: 5 }]

      start_squares = KnightComputation::MOVE.call(data)
      expect(start_squares).to eq(exp_start_squares)
    end
  end
end
