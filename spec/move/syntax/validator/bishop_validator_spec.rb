require './lib/move/syntax/validator/bishop_validator'
require './lib/standard/chess_piece'

RSpec.describe BishopValidator do
  
  describe '#validate' do
    subject(:validator) { described_class.new }

    context "when move is not a capture" do    
      context "when starting file or rank is unspecified" do
        context "when valid file and rank are specified for target square" do
          it "returns the move" do
            move_str = 'Ba5'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end

        context "when invalid file is specified for target square" do
          it "returns nil" do
            expect(validator.validate('Bz5', ChessPiece::BL)).to be_nil
          end
        end

        context "when invalid rank is specified for target square" do
          it "returns nil" do
            expect(validator.validate('Ba9', ChessPiece::WH)).to be_nil
          end
        end
      end # context "when starting file or rank is unspecified"

      context "when starting file or rank is specified" do
        context "when the specified file is valid" do
          it "returns the move" do
            move_str = 'Bda5'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end

        context "when the specified rank is valid" do
          it "returns the move" do
            move_str = 'B1a5'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end

        context "when the specified file is invalid" do
          it "returns nil" do
            expect(validator.validate('Bza5', ChessPiece::BL)).to be_nil
          end
        end

        context "when the specified rank is invalid" do
          it "returns nil" do
            expect(validator.validate('B9a5', ChessPiece::WH)).to be_nil
          end
        end
      end # context "when starting file or rank is specified"
    end # context "when move is not a capture" do

    context "when move is a capture" do

      context "when starting file or rank is unspecified" do
        context "when valid file and rank are specified for the target square" do
          it "returns the move" do
            move_str = 'Bxa5'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end

        context "when invalid file is specified for the target square" do
          it "returns nil" do
            expect(validator.validate('Bxz5', ChessPiece::WH)).to be_nil
          end
        end

        context "when invalid rank is specified for the target square" do
          it "returns nil" do
            move_str = 'Bxa9'
            expect(validator.validate(move_str, ChessPiece::BL)).to be_nil
          end
        end
      end # context "when starting file or rank is unspecified"

      context "when starting file or rank is specified" do
        context "when specified file is valid" do
          it "returns the move" do
            move_str = 'Bdxa5'
            expect(validator.validate(move_str, ChessPiece::WH)).to eq(move_str)
          end
        end

        context "when specified file is invalid" do
          it "returns nil" do
            expect(validator.validate('Bzxa5', ChessPiece::WH)).to be_nil
          end
        end

        context "when specified rank is valid" do
          it "returns the move" do
            move_str = 'B1xa5'
            expect(validator.validate(move_str, ChessPiece::BL)).to eq(move_str)
          end
        end

        context "when specified rank is valid" do
          it "returns nil" do
            expect(validator.validate('B9xa5', ChessPiece::BL)).to be_nil
          end
        end
      end # context "when starting file or rank is specified"
    end # context "when move is a capture"
  end # describe '#validate'
end
