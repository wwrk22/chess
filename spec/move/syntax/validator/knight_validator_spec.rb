require './lib/move/syntax/validator/knight_validator'
require './lib/error/color_unknown_error'
require_relative './move_samples/knight'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
  cfg.include MoveSamples::Knight
end

RSpec.describe KnightValidator do

  describe '#validate' do
    subject(:validator) { described_class.new }

    let(:white_knight) { Knight.new(white) }
    let(:black_knight) { Knight.new(black) }

    matcher :eq_piece do |other_piece|
      match do |piece|
        piece.type == other_piece.type && piece.color == other_piece.color
      end
    end

    context "when move is not a capture" do 
      context "when syntax is valid" do
        context "when starting file or rank is not specified" do
          it "returns a ChessPiece representing the moving knight" do
            move_str = 'Na3'
            expect(validator.validate(move_str, white)).to eq_piece(white_knight)
          end
        end

        context "when starting file or rank is specified" do
          it "returns a ChessPiece representing the moving knight" do
            move_str = 'Nba3'
            expect(validator.validate(move_str, white)).to eq_piece(white_knight)
          end
        end
      end # context "when sytax is valid"

      context "when syntax is invalid" do 
        context "when starting file or rank is not specified" do
          it "returns nil" do
            expect(validator.validate('Nz3', black)).to be_nil
          end
        end

        context "when starting file or rank is specified" do
          it "returns nil" do
            expect(validator.validate('Naa3', black)).to be_nil
          end
        end
      end # context "when syntax is invalid"
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when syntax is valid" do
        context "when starting fle or rank is not specified" do
          it "returns a ChessPiece representing the moving knight" do
            move_str = 'Nxa3'
            expect(validator.validate(move_str, black)).to eq_piece(black_knight)
          end
        end

        context "when starting file or rank is specified" do
          it "returns a ChessPiece representing the moving knight" do
            move_str = 'Nbxa3'
            expect(validator.validate(move_str, black)).to eq_piece(black_knight)
          end
        end
      end # context "when syntax is valid"

      context "when syntax is invalid" do
        context "when starting fle or rank is not specified" do
          it "returns nil" do
            expect(validator.validate('Nxa9', white)).to be_nil
          end
        end

        context "when starting file or rank is specified" do
          it "returns nil" do
            expect(validator.validate('Nexa3', white)).to be_nil
          end
        end
      end # context "when syntax is invalid"
    end # context "when move is a capture"

    context "when validating all possible moves" do
      context "when all moves are legal" do
        it "returns a ChessPiece for every move" do
          result = legal_knight_moves.none? do |move|
            validator.validate(move, white).nil? # Color doesn't matter here
          end

          expect(result).to eq(true)
        end
      end

      context "when all moves are illegal" do
        it "returns nil for every move" do
          result = illegal_knight_moves.all? do |move|
            validator.validate(move, white).nil?
          end

          expect(result).to eq(true)
        end
      end
    end # context "when validating all possible moves"
  end # describe '#validate'
end
