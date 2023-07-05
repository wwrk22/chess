require './lib/move/syntax/piece_type_parser'


RSpec.describe PieceTypeParser do

  describe '#parse' do
    subject(:parser) { described_class.new }

    context "when the move is for a pawn" do
      it "returns 'P' to indicate pawn" do
        expect(parser.parse('a3')).to eq(ChessPiece::PA)
      end
    end

    context "when the move is for a rook" do
      it "returns 'R' to indicate rook" do
        expect(parser.parse('Rd4')).to eq(ChessPiece::RO)
      end
    end
  end # #parse

end
