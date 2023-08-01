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


  describe '#validate_capture' do
    context "when the move is for a white pawn" do
      context "when the move has valid syntax" do
        it "returns a ChessPiece object representing a white pawn" do
          result = validator.validate_capture('bxa3', white)
          expect(result).to eq_piece(white_pawn)
        end
      end

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate_capture('zxa3', white)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a white pawn"

    context "when the move is for a black pawn" do
      context "when the move has valid syntax" do
        it "returns a ChessPiece object representing a white pawn" do
          result = validator.validate_capture('bxa6', black)
          expect(result).to eq_piece(black_pawn)
        end
      end

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate_capture('zxa6', black)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a black pawn"
  end # describe '#validate_capture'


  describe '#validate_non_capture' do
    context "when the move is for a black pawn" do
      context "when the move has valid syntax" do
        it "returns a ChessPiece object representing a black pawn" do
          result = validator.validate_non_capture('a6', black)
          expect(result).to eq_piece(black_pawn)
        end
      end

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate_non_capture('z6', black)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a black pawn"
    
    context "when the move is for a white pawn" do
      context "when the move has valid syntax" do
        it "returns a ChessPiece object representing a white pawn" do
          white_pawn = ChessPiece.new(pawn, white)

          result = validator.validate_non_capture('a3', white)
          expect(result).to eq_piece(white_pawn)
        end
      end

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate_non_capture('z3', white)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a white pawn"
  end # describe '#validate_non_capture'


  describe '#validate' do
    context "when the move is a capture" do
      it "calls #validate_capture" do
        expect(validator).to receive(:validate_capture)
        validator.validate('bxa3', white)
      end
    end

    context "when the move is not a capture" do
      it "calls #validate_non_capture" do
        expect(validator).to receive(:validate_non_capture)
        validator.validate('a3', white)
      end
    end
  end # describe '#validate'
end
