require './lib/move/syntax/validator/pawn_validator'
require './lib/standard/chess_piece'
require './lib/error/color_unknown_error'

RSpec.describe PawnValidator do
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when player color is white" do
      context "when move is not a capture" do
        context "when syntax is valid" do
          it "returns the hash arg that was given" do
            move_str = 'a3'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end

        context "when syntax is invalid" do
          it "returns nil" do
            expect(validator.validate('a2', ChessPiece::WH)).to be_nil
          end
        end
      end # context "when move is not a capture"

      context "when move is a capture" do
        context "when syntax is valid" do
          it "returns the hash arg that was given" do
            move_str = 'bxa3'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end # context "when syntax is valid"

        context "when syntax is invalid" do
          it "returns nil" do
            expect(validator.validate('cxa2', ChessPiece::WH)).to be_nil
          end
        end # context "when syntax is invalid"
      end # context "when move is a capture"
    end # context "when player color is white"

    context "when player color is black" do
      context "when move is not a capture" do
        context "when syntax is valid" do
          it "returns the hash arg that was given" do
            move_str = 'h6'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end

        context "when syntax is invalid" do
          it "returns nil" do
            expect(validator.validate('h7', ChessPiece::BL)).to be_nil
          end
        end
      end # context "when move is not a capture"

      context "when move is a capture" do
        context "when syntax is valid" do
          it "returns the hash arg that was given" do
            move_str = 'gxh6'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end # context "when syntax is valid"

        context "when syntax is invalid" do
          it "returns nil" do
            expect(validator.validate('axh7', ChessPiece::BL)).to be_nil
          end
        end # context "when syntax is invalid"
      end # context "when move is a capture"
    end # context "when player color is black"

    context "when color is unknown" do
      it "raises ColorUnknownError" do
        expect{ validator.validate('a3', 'unknown') }.to raise_error(ColorUnknownError)
      end
    end
  end # describe '#validate'
end
