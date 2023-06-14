require './lib/move/syntax/rook_validator'
require './lib/standards/piece'
require './lib/errors/color_unknown_error'

RSpec.describe Move::Syntax::RookValidator do

  describe '#validate' do

  subject(:validator) { described_class.new }

    context "when move is not a capture" do
      context "when syntx is valid" do
        it "returns the move" do 
          move = { move: 'Ra5', color: Piece::WH }
          expect(validator.validate(move)).to eq(move)
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        it "returns nil" do
          move = { move: 'Rz5', color: Piece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end # context "when syntax is invalid"
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when syntax is valid" do
        it "returns the move" do
          move = { move: 'Rxa5', color: Piece::WH }
          expect(validator.validate(move)).to eq(move)
        end
      end

      context "when syntax is invalid" do
        it "returns nil" do
          move = { move: 'R9xa5', color: Piece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end # context "when syntax is invalid"
    end # context "when move is a capture"

    context "when color is unknown" do
      it "raises the ColorUnknownError" do
        move = { move: 'Ra5', color: 'blue' }
        expect{ validator.validate(move) }.to raise_error(ColorUnknownError)
      end
    end

  end # describe '#vaildate'

end
