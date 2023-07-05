require './lib/move/syntax/validator/bishop_validator'
require './lib/standard/chess_piece'

RSpec.describe Move::Syntax::BishopValidator do
  
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do
    
      context "when starting file or rank is unspecified" do
        context "when valid file and rank are specified for target square" do
          it "returns the move" do
            move = { move: 'Ba5', color: ChessPiece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when invalid file is specified for target square" do
          it "returns nil" do
            move = { move: 'Bz5', color: ChessPiece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when invalid rank is specified for target square" do
          it "returns nil" do
            move = { move: 'Ba9', color: ChessPiece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when starting file or rank is unspecified"

      context "when starting file or rank is specified" do
        context "when the specified file is valid" do
          it "returns the move" do
            move = { move: 'Bda5', color: ChessPiece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when the specified rank is valid" do
          it "returns the move" do
            move = { move: 'B1a5', color: ChessPiece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when the specified file is invalid" do
          it "returns nil" do
            move = { move: 'Bza5', color: ChessPiece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when the specified rank is invalid" do
          it "returns nil" do
            move = { move: 'B9a5', color: ChessPiece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when starting file or rank is specified"
    end # context "when move is not a capture" do

    context "when move is a capture" do

      context "when starting file or rank is unspecified" do
        context "when valid file and rank are specified for the target square" do
          it "returns the move" do
            move = { move: 'Bxa5', color: ChessPiece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when invalid file is specified for the target square" do
          it "returns nil" do
            move = { move: 'Bxz5', color: ChessPiece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when invalid rank is specified for the target square" do
          it "returns nil" do
            move = { move: 'Bxa9', color: ChessPiece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when starting file or rank is unspecified"

      context "when starting file or rank is specified" do
        context "when specified file is valid" do
          it "returns the move" do
            move = { move: 'Bdxa5', color: ChessPiece::WH }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when specified file is invalid" do
          it "returns nil" do
            move = { move: 'Bzxa5', color: ChessPiece::WH }
            expect(validator.validate(move)).to be_nil
          end
        end

        context "when specified rank is valid" do
          it "returns the move" do
            move = { move: 'B1xa5', color: ChessPiece::BL }
            expect(validator.validate(move)).to eq(move)
          end
        end

        context "when specified rank is valid" do
          it "returns nil" do
            move = { move: 'B9xa5', color: ChessPiece::BL }
            expect(validator.validate(move)).to be_nil
          end
        end
      end # context "when starting file or rank is specified"
    end # context "when move is a capture"
  end # describe '#validate'
end
