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


  describe '#validate_capture_move' do
    context "when the move is for a white pawn" do
      context "when the move has valid syntax" do
        it "returns a ChessPiece object representing a white pawn" do
          result = validator.validate_capture_move('bxa3', white)
          expect(result).to eq_piece(white_pawn)
        end
      end

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate_capture_move('zxa3', white)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a white pawn"

    context "when the move is for a black pawn" do
      context "when the move has valid syntax" do
        it "returns a ChessPiece object representing a white pawn" do
          result = validator.validate_capture_move('bxa6', black)
          expect(result).to eq_piece(black_pawn)
        end
      end

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate_capture_move('zxa6', black)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a black pawn"
  end # describe '#validate_capture_move'


  describe '#validate_non_capture_move' do
    context "when the move is for a black pawn" do
      context "when the move has valid syntax" do
        it "returns a ChessPiece object representing a black pawn" do
          result = validator.validate_non_capture_move('a6', black)
          expect(result).to eq_piece(black_pawn)
        end
      end

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate_non_capture_move('z6', black)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a black pawn"
    
    context "when the move is for a white pawn" do
      context "when the move has valid syntax" do
        it "returns a ChessPiece object representing a white pawn" do
          white_pawn = ChessPiece.new(pawn, white)

          result = validator.validate_non_capture_move('a3', white)
          expect(result).to eq_piece(white_pawn)
        end
      end

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate_non_capture_move('z3', white)
          expect(result).to be_nil
        end
      end
    end # context "when the move is for a white pawn"
  end # describe '#validate_non_capture_move'
end
