require 'support/matchers/chess_piece'
require './lib/move/syntax/validator/king_validator'
require './lib/piece/piece_specs'
require_relative './move_samples/king'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
  cfg.include MoveSamples::King
end

RSpec.describe KingValidator do
  describe '#validate' do
    subject(:validator) { described_class.new }

    let(:white_king) { ChessPiece.new(king, white) }
    let(:black_king) { ChessPiece.new(king, black) }

    context "when move is not a capture" do
      context "when target square has valid file and rank" do
        it "returns a ChessPiece representing the moving King" do
          move_str = 'Ke2'
          expect(validator.validate(move_str, white)).to eq_piece(white_king)
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
        it "returns a ChessPiece representing the moving King" do
          move_str = 'Kxe2'
          expect(validator.validate(move_str, white)).to eq_piece(white_king)
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
      it "returns a ChessPiece representing the moving King" do
        move_str = '0-0'
        expect(validator.validate(move_str, white)).to eq_piece(white_king)
      end
    end

    context "when move is a queen-side castle" do
      it "returns a ChessPiece representing the moving King" do
        move_str = '0-0-0'
        expect(validator.validate(move_str, black)).to eq_piece(black_king)
      end
    end

    context "when validating all possible moves" do
      context "when validating only legal moves" do
        it "returns a ChessPiece for every move" do
          result = legal_king_moves.none? do |move|
            validator.validate(move, white).nil?
          end

          expect(result).to eq(true)
        end
      end

      context "when validating only illegal moves" do
        it "returns nil for every move" do
          result = illegal_king_moves.all? do |move|
            validator.validate(move, white).nil?
          end

          expect(result).to eq(true)
        end
      end
    end # context "when validating all possible moves"
  end # describe '#validate'
end
