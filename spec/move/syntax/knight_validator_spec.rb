require './lib/move/syntax/knight_validator'
require './lib/standards/piece'
require './lib/errors/color_unknown_error'

RSpec.describe Move::Syntax::KnightValidator do

  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do 
      context "when syntax is valid" do
        context "when starting file or rank is not specified" do
          it "returns the move" do
            move = { move: 'Na3', color: Piece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when starting file or rank is specified" do
          it "returns the move" do
            move = { move: 'Nba3', color: Piece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end
      end # context "when sytax is valid"

      context "when syntax is invalid" do 
        context "when starting file or rank is not specified" do
          it "returns nil" do
            move = { move: 'Nz3', color: Piece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when starting file or rank is specified" do
          it "returns nil" do
            move = { move: 'Naa3', color: Piece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when syntax is invalid"
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when syntax is valid" do
        context "when starting fle or rank is not specified" do
          it "returns the move" do
            move = { move: 'Nxa3', color: Piece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when starting file or rank is specified" do
          it "returns the move" do
            move = { move: 'Nbxa3', color: Piece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        context "when starting fle or rank is not specified" do
          it "returns nil" do
            move = { move: 'Nxa9', color: Piece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when starting file or rank is specified" do
          it "returns nil" do
            move = { move: 'Nexa3', color: Piece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when syntax is invalid"
    end # context "when move is a capture"
  end # describe '#validate'
end
