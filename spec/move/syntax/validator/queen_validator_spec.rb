require './lib/move/syntax/validator/queen_validator'
require './lib/standard/chess_piece'

RSpec.describe Move::Syntax::QueenValidator do
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do
      context "when starting file or rank is unspecified" do
        context "when target square file and rank are valid" do
          it "returns the move" do
            move = { move: 'Qd4', color: ChessPiece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when target square file is invalid" do
          it "returns nil" do
            move = { move: 'Qz4', color: ChessPiece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when target square rank is invalid" do
          it "returns nil" do
            move = { move: 'Q94', color: ChessPiece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when starting file or rank is unspecified"

      context "when starting file is specified and valid" do
        it "returns the move" do
          move = { move: 'Qad4', color: ChessPiece::WH }
          expect(validator.validate(move)).to eq(move)
        end
      end

      context "when starting file is specified but invalid" do
        it "returns nil" do
          move = { move: 'Qzd4', color: ChessPiece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end

      context "when starting rank is specified and valid" do
        it "returns the move" do
          move = { move: 'Q1d4', color: ChessPiece::WH }
          expect(validator.validate(move)).to eq(move)
        end
      end

      context "when starting rank is specified but invalid" do
        it "returns nil" do
          move = { move: 'Q9d4', color: ChessPiece::BL }
          expect(validator.validate(move)).to be_nil
        end
      end
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when starting file or rank is unspecified" do
        context "when target square file and rank are valid" do
          it "returns the move" do
            move = { move: 'Qxd4', color: ChessPiece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when target square file is invalid" do
          it "returns nil" do
            move = { move: 'Qxz4', color: ChessPiece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when target square rank is invalid" do
          it "returns nil" do
            move = { move: 'Qxa9', color: ChessPiece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when starting file or rank is unspecified"

      context "when starting file or rank is specified" do
        context "when starting file is valid" do
          it "returns the move" do
            move = { move: 'Qaxd4', color: ChessPiece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when starting file is invalid" do
          it "returns nil" do
            move = { move: 'Qzxd4', color: ChessPiece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when starting rank is valid" do
          it "returns the move" do
            move = { move: 'Q1xd4', color: ChessPiece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when starting rank is invalid" do
          it "returns nil" do
            move = { move: 'Q9xd4', color: ChessPiece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when starting file or rank is specified"
    end # context "when move is a capture"
  end # describe '#validate'
end
