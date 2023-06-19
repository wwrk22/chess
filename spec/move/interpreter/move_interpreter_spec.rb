require './lib/move/interpreter/move_interpreter'
require './lib/standards/piece'

RSpec.describe MoveInterpreter do
  subject(:interpreter) { described_class.new(Piece::WH) }
  
  describe '#parse_piece' do
    context "when move is for a pawn" do
      it "returns the string 'P'" do
        move = 'a3'
        piece = interpreter.parse_piece(move)
        expect(piece).to eq(Piece::PA)
      end
    end

    context "when move is for a piece other than a pawn" do
      it "returns the first letter of the move" do
        move = 'Na3'
        piece = interpreter.parse_piece(move)
        expect(piece).to eq(Piece::KN)
      end
    end # context "when move is for a piece other than a pawn"
  end # describe '#parse_piece'
end
