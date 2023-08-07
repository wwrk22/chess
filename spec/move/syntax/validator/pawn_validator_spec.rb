require './lib/move/syntax/validator/pawn_validator'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe PawnValidator do
  matcher :eq_piece do |other_piece|
    match do |piece|
      piece.type == other_piece.type && piece.color == other_piece.color
    end
  end

  let(:black_pawn) { ChessPiece.new(pawn, black) }
  let(:white_pawn) { ChessPiece.new(pawn, white) }

  subject(:validator) { described_class.new }

  describe '#validate' do
    context "when the color is unknown" do
      it "raises ColorUnknownError" do
        unknown_color = 'unknown color'
        allow(validator).to receive(:valid_color?).with(unknown_color).and_return false

        expect{ validator.validate('a3', unknown_color) }.to raise_error(ColorUnknownError)
      end
    end

    context "when the color is known" do
      context "when pawn is white" do
        context "when the move matches the pattern" do
          it "returns a white pawn ChessPiece" do
            result = validator.validate('a3', white)
            expect(result).to eq_piece(white_pawn)
          end
        end

        context "when the move does not match the pattern" do
          it "returns nil" do
            result = validator.validate('a2', white)
            expect(result).to be_nil
          end
        end
      end # context "when pawn is white"

      context "when pawn is black" do
        context "when the move matches the pattern" do
          it "returns a black pawn ChessPiece" do
            result = validator.validate('a6', black)
            expect(result).to eq_piece(black_pawn)
          end
        end

        context "when the move does not match the pattern" do
          it "returns nil" do
            result = validator.validate('a7', black)
            expect(result).to be_nil
          end
        end
      end # context "when pawn is black"
    end # context "when the color is known"
  end # describe '#validate'
end
