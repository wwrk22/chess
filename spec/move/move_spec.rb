require './lib/move/move'
require './lib/standard/piece'
require './spec/support/move_helpers'

RSpec.configure do |cfg|
  cfg.include MoveHelpers
end

RSpec.describe Move do
  describe '#compute' do
    context "when a piece is moved without a starting file or rank" do
      subject(:move) { described_class.new }

      # Lambda returns a boolean to indicate whether or not the correct data
      # was given to it by #compute. If the data is correct, then it returns true.
      # Otherwise, it returns false.
      it "passes the correct set of data  to the computation lambda" do
        move = pawn_move
        pawn_move = ->(data) do
          (data[:target] && data[:color]) ? true : false
        end

        expect(move.compute(&pawn_move)).to eq(true)
      end
    end

    context "when a piece is moved with a starting file or rank" do
      subject(:move) { described_class.new }

      it "passes the correct set of data to the computation lambda" do
        capture = pawn_capture
        pawn_capture = ->(data) do
          data[:target] && data[:color] && data[:start_f] ? true : false
        end

        expect(capture.compute(&pawn_capture)).to eq(true)
      end
    end
  end
end
