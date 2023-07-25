require './lib/move/syntax/validator/king_validator'
require './lib/standard/chess_piece'

RSpec.describe KingValidator do
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do
      context "when target square has valid file and rank" do
        it "returns the move" do
          move_str = 'Ke2'
          expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
        end
      end

      context "when target square has invalid file" do
        it "returns nil" do
          expect(validator.validate('Kz2', ChessPiece::BL)).to be_nil
        end
      end

      context "when target square has invalid rank" do
        it "returns nil" do
          expect(validator.validate('Ke9', ChessPiece::WH)).to be_nil
        end
      end

      context "when starting file or rank is specified" do
        it "returns nil" do
          expect(validator.validate('Kde2', ChessPiece::BL)).to be_nil
        end
      end
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when target square has valid file and rank" do
        it "returns the move" do
          move_str = 'Kxe2'
          expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
        end
      end

      context "when target square has invalid file" do
        it "returns nil" do
          expect(validator.validate('Kxz2', ChessPiece::BL)).to be_nil
        end
      end

      context "when target square has invalid rank" do
        it "returns nil" do
          expect(validator.validate('Kxe9', ChessPiece::WH)).to be_nil
        end
      end

      context "when starting file or rank is specified" do
        it "returns nil" do
          expect(validator.validate('Kdxe2', ChessPiece::BL)).to be_nil
        end
      end
    end # context "when move is a capture"

    context "when move is a king-side castle" do
      it "returns the move" do
        move_str = '0-0'
        expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
      end
    end

    context "when move is a queen-side castle" do
      it "returns the move" do
        move_str = '0-0-0'
        expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
      end
    end
  end # describe '#validate'
end
