require './lib/move/syntax/validator/queen_validator'
require './lib/standard/chess_piece'

RSpec.describe QueenValidator do
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do
      context "when starting file or rank is unspecified" do
        context "when target square file and rank are valid" do
          it "returns the move" do
            move_str = 'Qd4'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end

        context "when target square file is invalid" do
          it "returns nil" do
            expect(validator.validate('Qz4', ChessPiece::BL)).to be_nil
          end
        end

        context "when target square rank is invalid" do
          it "returns nil" do
            expect(validator.validate('Q94', ChessPiece::BL)).to be_nil
          end
        end
      end # context "when starting file or rank is unspecified"

      context "when starting file is specified and valid" do
        it "returns the move" do
          move_str = 'Qad4'
          expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
        end
      end

      context "when starting file is specified but invalid" do
        it "returns nil" do
          expect(validator.validate('Qzd4', ChessPiece::BL)).to be_nil
        end
      end

      context "when starting rank is specified and valid" do
        it "returns the move" do
          move_str = 'Q1d4'
          expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
        end
      end

      context "when starting rank is specified but invalid" do
        it "returns nil" do
          expect(validator.validate('Q9d4', ChessPiece::BL)).to be_nil
        end
      end
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when starting file or rank is unspecified" do
        context "when target square file and rank are valid" do
          it "returns the move" do
            move_str = 'Qxd4'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end

        context "when target square file is invalid" do
          it "returns nil" do
            expect(validator.validate('Qxz4', ChessPiece::BL)).to be_nil
          end
        end

        context "when target square rank is invalid" do
          it "returns nil" do
            expect(validator.validate('Qxa9', ChessPiece::WH)).to be_nil
          end
        end
      end # context "when starting file or rank is unspecified"

      context "when starting file or rank is specified" do
        context "when starting file is valid" do
          it "returns the move" do
            move_str = 'Qaxd4'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end

        context "when starting file is invalid" do
          it "returns nil" do
            expect(validator.validate('Qzxd4', ChessPiece::WH)).to be_nil
          end
        end

        context "when starting rank is valid" do
          it "returns the move" do
            move_str = 'Q1xd4'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end

        context "when starting rank is invalid" do
          it "returns nil" do
            expect(validator.validate('Q9xd4', ChessPiece::WH)).to be_nil
          end
        end
      end # context "when starting file or rank is specified"
    end # context "when move is a capture"
  end # describe '#validate'
end
