require './lib/move/syntax/validator/rook_validator'
require './lib/standard/chess_piece'
require './lib/error/color_unknown_error'

RSpec.describe Move::Syntax::RookValidator do

  describe '#validate' do

  subject(:validator) { described_class.new }

    context "when move is not a capture" do
      context "when syntx is valid" do
        context "when starting file or rank is specified" do
          it "returns the move" do 
            move = { move: 'R8a5', color: ChessPiece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when starting file or rank is not specified" do
          it "returns the move" do 
            move = { move: 'Ra5', color: ChessPiece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        it "returns nil" do
          move = { move: 'Rz5', color: ChessPiece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end # context "when syntax is invalid"
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when syntax is valid" do
        context "when starting file or rank is specified" do
          it "returns the move" do
            move = { move: 'Rdxa5', color: ChessPiece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when starting file or rank is not specified" do
          it "returns the move" do
            move = { move: 'Rxa5', color: ChessPiece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        it "returns nil" do
          move = { move: 'R9xa5', color: ChessPiece::BL }
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

  end # describe '#validate'

end
