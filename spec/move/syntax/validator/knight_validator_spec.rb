require './lib/move/syntax/validator/knight_validator'
require './lib/standard/chess_piece'
require './lib/error/color_unknown_error'

RSpec.describe KnightValidator do

  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do 
      context "when syntax is valid" do
        context "when starting file or rank is not specified" do
          it "returns the move" do
            move_str = 'Na3'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end

        context "when starting file or rank is specified" do
          it "returns the move" do
            move_str = 'Nba3'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end
      end # context "when sytax is valid"

      context "when syntax is invalid" do 
        context "when starting file or rank is not specified" do
          it "returns nil" do
            expect(validator.validate('Nz3', ChessPiece::BL)).to be_nil
          end
        end

        context "when starting file or rank is specified" do
          it "returns nil" do
            expect(validator.validate('Naa3', ChessPiece::BL)).to be_nil
          end
        end
      end # context "when syntax is invalid"
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when syntax is valid" do
        context "when starting fle or rank is not specified" do
          it "returns the move" do
            move_str = 'Nxa3'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end

        context "when starting file or rank is specified" do
          it "returns the move" do
            move_str = 'Nbxa3'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        context "when starting fle or rank is not specified" do
          it "returns nil" do
            expect(validator.validate('Nxa9', ChessPiece::WH)).to be_nil
          end
        end

        context "when starting file or rank is specified" do
          it "returns nil" do
            expect(validator.validate('Nexa3', ChessPiece::WH)).to be_nil
          end
        end
      end # context "when syntax is invalid"
    end # context "when move is a capture"
  end # describe '#validate'
end
