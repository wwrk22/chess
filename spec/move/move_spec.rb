require './lib/move/move'
require './lib/standard'
require './lib/standards/piece'

RSpec.describe Move do
  subject(:move) { described_class.new }

  describe '#compute_starts' do
    context "when all attributes except @starts are populated" do
      it "computes all possible starting squares to save in @starts, then returns true" do
        # move 'a3' for white
        move.instance_variable_set(:@target, { f: 'a', r: 3 })
        move.instance_variable_set(:@piece, Piece::PA)
        move.instance_variable_set(:@color, Piece::WH)

        result = move.compute_starts do |data|
          # Logic to compute all possible starting squares would go here.
          [{ f: 'a', r: 2 }]
        end

        expect(result).to eq(true)
      end
    end

    context "when not all attributes, except @starts, are populated" do
      it "does nothing and returns false" do
        # Return value of the block doesn't matter here since it won't be called.
        result = move.compute_starts { |data| nil }
        expect(result).to eq(false)
      end
    end
  end # describe #compute_starts
end
