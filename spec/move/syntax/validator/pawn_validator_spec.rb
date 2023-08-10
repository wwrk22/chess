require './lib/move/syntax/validator/pawn_validator'
require './lib/piece/pawn'
require './lib/piece/piece_specs'
require './lib/error/color_unknown_error'
require_relative './move_samples/pawn'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
  cfg.include MoveSamples::Pawn
end

RSpec.describe PawnValidator do
  matcher :eq_piece do |other_piece|
    match do |piece|
      piece.type == other_piece.type && piece.color == other_piece.color
    end
  end

  let(:black_pawn) { Pawn.new(black) }
  let(:white_pawn) { Pawn.new(white) }

  subject(:validator) { described_class.new }

  describe '#validate' do
    context "when pawn is white" do
      context "when the move matches the pattern" do
        it "returns a white Pawn" do
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

    context "when validating all possible moves" do
      context "when all moves are legal" do
        it "returns a ChessPiece for all valid moves" do
          wh_result = legal_wh_pawn_moves.none? do |move|
            validator.validate(move, white).nil?
          end

          bl_result = legal_bl_pawn_moves.none? do |move|
            validator.validate(move, black).nil?
          end

          expect(wh_result && bl_result).to eq(true)
        end
      end

      context "when all moves are illegal for white" do
        it "returns nil for all moves" do
          result = illegal_wh_pawn_moves.all? do |move|
            validator.validate(move, white).nil?
          end

          expect(result).to eq(true)
        end
      end

      context "when all moves are illegal for black" do
        it "returns nil for all moves" do
          result = illegal_bl_pawn_moves.all? do |move|
            validator.validate(move, black).nil?
          end

          expect(result).to eq(true)
        end
      end
    end # context "when validating all possible moves"
  end # describe '#validate'
end
