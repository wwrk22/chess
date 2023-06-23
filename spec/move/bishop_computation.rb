require './lib/move/bishop_computation'

RSpec.describe BishopComputation do 
  context "when the move has a start file" do 
    it "returns the two possible starting squares of the start file" do
      data = { target: { f: 'd', r: 4 }, start_f: 'b' }
      exp_start_squares = [{ f: 'b', r: 2 }, { f: 'b', r: 6 }]

      start_squares = BishopComputation::MOVE.call(data)
      expect(start_squares.difference(exp_start_squares)).to be_empty
    end
  end

  context "when the move has a start rank" do
    it "returns the two possible starting squares of the start file" do
      data = { target: { f: 'd', r: 4 }, start_r: 2 }
      exp_start_squares = [{ f: 'b', r: 2 }, { f: 'f', r: 2 }]

      start_squares = BishopComputation::MOVE.call(data)
      expect(start_squares.difference(exp_start_squares)).to be_empty
    end
  end

  context "when the move does not have a start file or rank" do
    it "returns all of the possible starting squares" do
      data = { target: { f: 'd', r: 4 } }
      exp_start_squares = [{:f=>"d", :r=>4}, {:f=>"c", :r=>3}, {:f=>"b", :r=>2},
                           {:f=>"a", :r=>1}, {:f=>"e", :r=>5}, {:f=>"f", :r=>6},
                           {:f=>"g", :r=>7}, {:f=>"h", :r=>8}, {:f=>"d", :r=>4},
                           {:f=>"c", :r=>5}, {:f=>"b", :r=>6}, {:f=>"a", :r=>7},
                           {:f=>"e", :r=>3}, {:f=>"f", :r=>2}, {:f=>"g", :r=>1}]

      start_squares = BishopComputation::MOVE.call(data)
      expect(start_squares.difference(exp_start_squares)).to be_empty
    end
  end
end
