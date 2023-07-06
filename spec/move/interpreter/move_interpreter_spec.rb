require './lib/move/interpreter/move_interpreter'
require './lib/standard/chess_piece'


RSpec.describe MoveInterpreter do
  subject(:interpreter) { described_class.new(ChessPiece::WH) }
  
  describe '#parse_piece' do
    context "when move is for a pawn" do
      it "returns the string 'P'" do
        move = 'a3'
        piece = interpreter.parse_piece(move)
        expect(piece).to eq(ChessPiece::PA)
      end
    end

    context "when move is for a piece other than a pawn" do
      it "returns the first letter of the move" do
        move = 'Na3'
        piece = interpreter.parse_piece(move)
        expect(piece).to eq(ChessPiece::KN)
      end
    end # context "when move is for a piece other than a pawn"
  end # describe '#parse_piece'

  describe '#parse_target' do
    context "when move is a check or checkmate" do
      it "returns true" do
        move = 'bxa3+'
        target = interpreter.parse_target(move)
        expect(target).to eq({ f: 'a', r: 3 })
      end
    end

    context "when move is not a check or checkmate" do
      it "returns true" do
        move = 'Nba3'
        target = interpreter.parse_target(move)
        expect(target).to eq({ f: 'a', r: 3 })
      end
    end
  end # describe '#parse_target'

  describe '#capture?' do
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

  describe '#parse_start_fr' do
    context "when move is for a pawn" do
      it "returns the file or rank of the moving pawn" do
        expect(interpreter.parse_start_fr('axb3')).to eq('a')
      end
    end

    context "when move is for a piece other than pawn and king" do
      context "when move is a capture" do
        it "returns the file or rank of the capturing piece" do
          expect(interpreter.parse_start_fr('Raxd4')).to eq('a')
        end
      end

      context "when move is not a capture" do
        it "returns the file or rank of the moving piece" do
          expect(interpreter.parse_start_fr('Nba3')).to eq('b')
        end
      end
    end
  end # describe '#parse_start_fr'
end
