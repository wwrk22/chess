require './lib/move/syntax/validator/king_validator'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe KingValidator do
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do
      context "when target square has valid file and rank" do
        it "returns the abbreviation for King" do
          move_str = 'Ke2'
          expect(validator.validate(move_str, white)).to eq(king)
        end
      end

      context "when target square has invalid file" do
        it "returns nil" do
          expect(validator.validate('Kz2', black)).to be_nil
        end
      end

      context "when target square has invalid rank" do
        it "returns nil" do
          expect(validator.validate('Ke9', white)).to be_nil
        end
      end

      context "when starting file or rank is specified" do
        it "returns nil" do
          expect(validator.validate('Kde2', black)).to be_nil
        end
      end
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when target square has valid file and rank" do
        it "returns the abbreviation for King" do
          move_str = 'Kxe2'
          expect(validator.validate(move_str, white)).to eq(king)
        end
      end

      context "when target square has invalid file" do
        it "returns nil" do
          expect(validator.validate('Kxz2', black)).to be_nil
        end
      end

      context "when target square has invalid rank" do
        it "returns nil" do
          expect(validator.validate('Kxe9', white)).to be_nil
        end
      end

      context "when starting file or rank is specified" do
        it "returns nil" do
          expect(validator.validate('Kdxe2', black)).to be_nil
        end
      end
    end # context "when move is a capture"

    context "when move is a king-side castle" do
      it "returns the abbreviation for King" do
        move_str = '0-0'
        expect(validator.validate(move_str, white)).to eq(king)
      end
    end

    context "when move is a queen-side castle" do
      it "returns the abbreviation for King" do
        move_str = '0-0-0'
        expect(validator.validate(move_str, black)).to eq(king)
      end
    end
  end # describe '#validate'
end
