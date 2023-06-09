require './lib/move/syntax/validator/king_validator'
require './lib/standard/chess_piece'

RSpec.describe KingValidator do
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do
      context "when target square has valid file and rank" do
        it "returns the move" do
          move = { move: 'Ke2', color: ChessPiece::WH }
          expect(validator.validate(move)).to eq(move)
        end
      end

      context "when target square has invalid file" do
        it "returns nil" do
          move = { move: 'Kz2', color: ChessPiece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end

      context "when target square has invalid rank" do
        it "returns nil" do
          move = { move: 'Ke9', color: ChessPiece::WH }
          expect(validator.validate(move)).to be_nil
        end
      end

      context "when starting file or rank is specified" do
        it "returns nil" do
          move = { move: 'Kde2', color: ChessPiece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when target square has valid file and rank" do
        it "returns the move" do
          move = { move: 'Kxe2', color: ChessPiece::WH }
          expect(validator.validate(move)).to eq(move)
        end
      end

      context "when target square has invalid file" do
        it "returns nil" do
          move = { move: 'Kxz2', color: ChessPiece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end

      context "when target square has invalid rank" do
        it "returns nil" do
          move = { move: 'Kxe9', color: ChessPiece::WH }
          expect(validator.validate(move)).to be_nil
        end
      end

      context "when starting file or rank is specified" do
        it "returns nil" do
          move = { move: 'Kdxe2', color: ChessPiece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end
    end # context "when move is a capture"

    context "when move is a king-side castle" do
      it "returns the move" do
        move = { move: '0-0', color: ChessPiece::WH }
        expect(validator.validate(move)).to eq(move)
      end
    end

    context "when move is a queen-side castle" do
      it "returns the move" do
        move = { move: '0-0-0', color: ChessPiece::BL }
        expect(validator.validate(move)).to eq(move)
      end
    end
  end # describe '#validate'
end
