require './lib/move/interpreter/move_interpreter'
require './lib/standard/chess_piece'


RSpec.describe MoveInterpreter do
  describe '#parse_target' do
    subject(:interpreter) { described_class.new(ChessPiece::WH) }
      
    context "when move is a check or checkmate" do
      it "returns true" do
        move = 'bxa3+'
        target = interpreter.parse_target(move)
        expect(target).to eq({ file: 'a', rank: 3 })
      end
    end

    context "when move is not a check or checkmate" do
      it "returns true" do
        move = 'Nba3'
        target = interpreter.parse_target(move)
        expect(target).to eq({ file: 'a', rank: 3 })
      end
    end
  end # describe '#parse_target'

  describe '#capture?' do
    subject(:interpreter) { described_class.new(ChessPiece::WH) }
      
    context "when move is a capture" do
      context "when move is a check or checkmate" do
        it "returns true" do
          move = 'bxa3+'
          expect(interpreter.capture?(move)).to eq(true)
        end
      end

      context "when move is not a check or checkmate" do
        it "returns false" do
          move = 'bxa3'
          expect(interpreter.capture?(move)).to eq(true)
        end
      end
    end

    context "when move is not a capture" do
      context "when move is a check or checkmate" do
        it "returns true" do
          move = 'Nba3#'
          expect(interpreter.capture?(move)).to eq(false)
        end
      end

      context "when move is not a check or checkmate" do
        it "returns false" do
          move = 'Nba3'
          expect(interpreter.capture?(move)).to eq(false)
        end
      end
    end # context "when move is not a capture"
  end # describe '#capture?'

  describe '#parse_starting_square' do
    subject(:interpreter) { described_class.new(ChessPiece::WH) }
      
    context "when move is for a pawn" do
      it "returns the file or rank of the moving pawn" do
        expect(interpreter.parse_starting_square('axb3')).to eq({ file: 'a' })
      end
    end

    context "when move is for a piece other than pawn and king" do
      context "when move is a capture" do
        it "returns the file or rank of the capturing piece" do
          expect(interpreter.parse_starting_square('Raxd4')).to eq({ file: 'a' })
        end
      end

      context "when move is not a capture" do
        it "returns the file or rank of the moving piece" do
          expect(interpreter.parse_starting_square('Nba3')).to eq({ file: 'b' })
        end
      end
    end
  end # describe '#parse_starting_square'
end
