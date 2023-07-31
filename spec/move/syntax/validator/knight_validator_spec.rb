require './lib/move/syntax/validator/knight_validator'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe KnightValidator do

  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do 
      context "when syntax is valid" do
        context "when starting file or rank is not specified" do
          it "returns the abbreviation for Knight" do
            move_str = 'Na3'
            expect(validator.validate(move_str, white)).to eq(knight)
          end
        end

        context "when starting file or rank is specified" do
          it "returns the abbreviation for Knight" do
            move_str = 'Nba3'
            expect(validator.validate(move_str, white)).to eq(knight)
          end
        end
      end # context "when sytax is valid"

      context "when syntax is invalid" do 
        context "when starting file or rank is not specified" do
          it "returns nil" do
            expect(validator.validate('Nz3', black)).to be_nil
          end
        end

        context "when starting file or rank is specified" do
          it "returns nil" do
            expect(validator.validate('Naa3', black)).to be_nil
          end
        end
      end # context "when syntax is invalid"
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when syntax is valid" do
        context "when starting fle or rank is not specified" do
          it "returns the abbreviation for Knight" do
            move_str = 'Nxa3'
            expect(validator.validate(move_str, black)).to eq(knight)
          end
        end

        context "when starting file or rank is specified" do
          it "returns the abbreviation for Knight" do
            move_str = 'Nbxa3'
            expect(validator.validate(move_str, black)).to eq(knight)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        context "when starting fle or rank is not specified" do
          it "returns nil" do
            expect(validator.validate('Nxa9', white)).to be_nil
          end
        end

        context "when starting file or rank is specified" do
          it "returns nil" do
            expect(validator.validate('Nexa3', white)).to be_nil
          end
        end
      end # context "when syntax is invalid"
    end # context "when move is a capture"
  end # describe '#validate'
end
