require './lib/move/syntax/pawn_validator'
require './lib/standards/piece'
require './lib/errors/color_unknown_error'

RSpec.describe Move::Syntax::PawnValidator do
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when player color is white" do
      context "when move is not a capture" do
        context "when syntax is valid" do
          it "returns the hash arg that was given" do
            move = { move: 'a3', color: Piece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when syntax is invalid" do
          it "returns nil" do
            move = { move: 'a2', color: Piece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when move is not a capture"

      context "when move is a capture" do
        context "when syntax is valid" do
          it "returns the hash arg that was given" do
            move = { move: 'bxa3', color: Piece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end # context "when syntax is valid"

        context "when syntax is invalid" do
          it "returns nil" do
            move = { move: 'cxa2', color: Piece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end # context "when syntax is invalid"
      end # context "when move is a capture"
    end # context "when player color is white"

    context "when player color is black" do
      context "when move is not a capture" do
        context "when syntax is valid" do
          it "returns the hash arg that was given" do
            move = { move: 'h6', color: Piece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when syntax is invalid" do
          it "returns nil" do
            move = { move: 'h7', color: Piece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when move is not a capture"

      context "when move is a capture" do
        context "when syntax is valid" do
          it "returns the hash arg that was given" do
            move = { move: 'gxh6', color: Piece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end # context "when syntax is valid"

        context "when syntax is invalid" do
          it "returns nil" do
            move = { move: 'axh7', color: Piece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end # context "when syntax is invalid"
      end # context "when move is a capture"
    end # context "when player color is black"

    context "when color is unknown" do
      it "raises ColorUnknownError" do
        move = { move: 'a3', color: 'unknown' }
        expect{ validator.validate(move) }.to raise_error(ColorUnknownError)
      end
    end

  end # describe '#validate'
end
