require './lib/move/syntax/pawn_validator'
require './lib/standards/piece'

RSpec.describe Move::Syntax::PawnValidator do
  describe '#validate' do
    context "when player color is white" do
      context "when move is not a capture" do
        context "when syntax is valid" do
          subject(:validator) { described_class.new }

          it "returns the hash arg that was given" do
            move = { move: 'a3', color: Piece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when syntax is invalid" do
        end
      end
    end
  end
end
