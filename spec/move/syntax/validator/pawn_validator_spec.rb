require './lib/move/syntax/validator/pawn_validator'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe PawnValidator do
  describe '#validate_capture_move' do
    context "when the move is for a white pawn" do
      context "when the move has valid syntax" do
        subject(:validator) { described_class.new }

        matcher :eq_piece do |other_piece|
          match do |piece|
            piece.type == other_piece.type && piece.color == other_piece.color
          end
        end

        it "returns a ChessPiece object representing a white pawn" do
          white_pawn = ChessPiece.new(pawn, white)

          result = validator.validate_capture_move('bxa3', white)
          expect(result).to eq_piece(white_pawn)
        end
      end

      context "when the move has invalid syntax" do
        subject(:validator) { described_class.new }

        it "returns nil" do
          white_pawn = ChessPiece.new(pawn, white)

          result = validator.validate_capture_move('zxa3', white)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a white pawn"

    context "when the move is for a black pawn" do
      context "when the move has valid syntax" do
        subject(:validator) { described_class.new }

        matcher :eq_piece do |other_piece|
          match do |piece|
            piece.type == other_piece.type && piece.color == other_piece.color
          end
        end

        it "returns a ChessPiece object representing a white pawn" do
          black_pawn = ChessPiece.new(pawn, black)

          result = validator.validate_capture_move('bxa6', black)
          expect(result).to eq_piece(black_pawn)
        end
      end

      context "when the move has invalid syntax" do
        subject(:validator) { described_class.new }

        it "returns nil" do
          black_pawn = ChessPiece.new(pawn, black)

          result = validator.validate_capture_move('zxa6', black)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a black pawn"
  end # describe '#validate_capture_move'
end
