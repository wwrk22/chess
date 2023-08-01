require './lib/move/syntax/validator/rook_validator'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'
require './lib/piece/chess_piece'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe RookValidator do
  subject(:validator) { described_class.new }

  let(:black_rook) { ChessPiece.new(rook, black) }
  let(:white_rook) { ChessPiece.new(rook, white) }

  matcher :eq_piece do |other_piece|
    match do |piece|
      piece.type == other_piece.type && piece.color == other_piece.color
    end
  end

  describe '#validate' do
    context "when move is not a capture" do
      context "when syntx is valid" do
        context "when starting file or rank is specified" do
          it "returns a ChessPiece representing the rook" do 
            move_str = 'R8a5'
            expect(validator.validate(move_str, black)).to eq_piece(black_rook)
          end
        end

        context "when starting file or rank is not specified" do
          it "returns a ChessPiece representing the rook" do 
            move_str = 'Ra5'
            expect(validator.validate(move_str, white)).to eq_piece(white_rook)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        it "returns nil" do
          expect(validator.validate('Rz5', black)).to be_nil
        end
      end # context "when syntax is invalid"
    end # context "when move is not a capture"
  end # describe '#validate'


  describe '#validate_capture' do
    context "when the move has valid syntax" do
      it "returns a ChessPiece representing the rook moving" do
        result = validator.validate_capture('Rxa5', white)
        expect(result).to eq_piece(white_rook)
      end
    end

    context "when the move has invalid syntax" do
      it "returns nil" do
        result = validator.validate_capture('Rxz5', white)
        expect(result).to be_nil
      end
    end
  end # describe '#validate_capture'

end
