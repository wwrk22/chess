require './lib/move/syntax/validator/rook_validator'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe RookValidator do

  describe '#validate' do

  subject(:validator) { described_class.new }

    context "when move is not a capture" do
      context "when syntx is valid" do
        context "when starting file or rank is specified" do
          it "returns the abbreviation for Rook" do 
            move_str = 'R8a5'
            expect(validator.validate(move_str, black)).to eq(rook)
          end
        end

        context "when starting file or rank is not specified" do
          it "returns the abbreviation for Rook" do 
            move_str = 'Ra5'
            expect(validator.validate(move_str, white)).to eq(rook)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        it "returns nil" do
          expect(validator.validate('Rz5', black)).to be_nil
        end
      end # context "when syntax is invalid"
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when syntax is valid" do
        context "when starting file or rank is specified" do
          it "returns the abbreviation for Rook" do
            move_str = 'Rdxa5'
            expect(validator.validate(move_str, white)).to eq(rook)
          end
        end

        context "when starting file or rank is not specified" do
          it "returns the abbreviation for Rook" do
            move_str = 'Rxa5'
            expect(validator.validate(move_str, black)).to eq(rook)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        it "returns nil" do
          expect(validator.validate('R9xa5', black)).to be_nil
        end
      end # context "when syntax is invalid"
    end # context "when move is a capture"

    context "when color is unknown" do
      it "raises the ColorUnknownError" do
        expect{ validator.validate('Ra5', 'blue') }.to raise_error(ColorUnknownError)
      end
    end

  end # describe '#validate'

end
