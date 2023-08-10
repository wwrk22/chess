require './lib/move/syntax/validator/rook_validator'
require './lib/piece/piece_specs'
require './lib/piece/rook'
require './lib/error/color_unknown_error'
require_relative './move_samples/rook'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
  cfg.include TestMoves::Rook
end

RSpec.describe RookValidator do
  subject(:validator) { described_class.new }

  let(:black_rook) { Rook.new(black) }
  let(:white_rook) { Rook.new(white) }

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

    context "when move is a capture" do
      context "when the move has valid syntax" do
        context "when starting file or rank is not specified" do
          it "returns a ChessPiece representing the rook moving" do
            result = validator.validate('Rxa5', white)
            expect(result).to eq_piece(white_rook)
          end
        end

        context "when starting file or rank is specified" do
          it "returns a ChessPiece representing the rook moving" do
            result = validator.validate('Rbxa5', white)
            expect(result).to eq_piece(white_rook)
          end
        end
      end # context "when the move has valid syntax"

      context "when the move has invalid syntax" do
        it "returns nil" do
          result = validator.validate('Rxz5', white)
          expect(result).to be_nil
        end
      end
    end # context "when move is a capture"

    context "when validating all possible moves" do
      context "when all moves are non-captures" do
        it "returns a ChessPiece for every move" do
          result_1 = rook_moves.none? do |move|
            validator.validate(move, white).nil? # color doesn't matter here
          end

          result_2 = rook_moves.none? do |move|
            validator.validate(move + '+', white).nil?
          end

          result_3 = rook_moves.none? do |move|
            validator.validate(move + '#', white).nil?
          end

          expect(result_1 && result_2 && result_3).to eq(true)
        end
      end # context "when all moves are non-captures"

      context "when all moves are captures" do
        it "returns a ChessPiece for every move" do
          result_1 = rook_captures.none? do |move|
            validator.validate(move, white).nil?
          end

          result_2 = rook_captures.none? do |move|
            validator.validate(move + '+', white).nil?
          end

          result_3 = rook_captures.none? do |move|
            validator.validate(move + '#', white).nil?
          end

          expect(result_1 && result_2 && result_3).to eq(true)
        end
      end # context "when all moves are captures"
    end
  end # describe '#validate'
end
