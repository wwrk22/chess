require './lib/move/rook_computation'
require './spec/support/computation_helpers.rb'

RSpec.configure do |cfg|
  cfg.include ComputationHelpers
end

RSpec.describe RookComputation do
  context "when the move has a start file" do
    it "returns the square of the start file and same rank as the target square" do
      data = { target: { f: 'd', r: 4 }, start_f: 'a' }
      exp_start_square = [{ f: 'a', r: 4 }]

      start_square = RookComputation::MOVE.call(data)
      expect(start_square).to eq(exp_start_square)
    end
  end

  context "when the move has a start rank" do
    it "returns the square of the start rank and same file as the target square" do
      data = { target: { f: 'd', r: 4 }, start_r: 1 }
      exp_start_square = [{ f: 'd', r: 1 }]

      start_square = RookComputation::MOVE.call(data)
      expect(start_square).to eq(exp_start_square)
    end
  end

  context "when the move does not have a start file or rank" do
    let(:file_d) { get_file('d') }
    let(:rank_4) { get_rank(4) }

    before do
      allow(Board).to receive(:get_line).with('d').and_return(file_d)
      allow(Board).to receive(:get_line).with(4).and_return(rank_4)
    end

    it "returns the whole file and rank of the target square except for the target square itself" do
      data = { target: { f: 'd', r: 4 } }
      exp_start_squares = file_d.concat(rank_4)
      exp_start_squares.delete(data[:target])

      start_squares = RookComputation::MOVE.call(data)
      expect(start_squares).to eq(exp_start_squares)
    end
  end
end
