require './lib/board/board'
require './lib/move/computer/king_start_computer'
require './lib/piece/chess_piece'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end


RSpec.describe KingStartComputer do
  subject(:computer) { described_class.new }

  describe '#all_possible_start_sqs' do
    it "returns all possible valid starting squares for a king move" do
      target_sq = { file: 'a', rank: 1 }
      expected = [{ file: 'a', rank: 2 }, { file: 'b', rank: 2 },
                  { file: 'b', rank: 1 }]

      result = computer.all_possible_start_sqs(target_sq)

      expect(result).to eq(expected)
    end
  end # describe '#all_possible_start_sqs'

  
  describe '#find_king' do
    context "when none of the starting squares have the king" do
      it "returns nil" do
        start_sqs = [{ file: 'a', rank: 1 }, { file: 'b', rank: 2 }]
        white_king = ChessPiece.new(king, white)
        board = instance_double(Board)

        allow(board).to receive(:at_sq).with(start_sqs[0]).and_return nil
        allow(board).to receive(:at_sq).with(start_sqs[1]).and_return nil

        result = computer.find_king(white_king, start_sqs, board)

        expect(result). to be_nil
      end
    end

    context "when one of the starting squares has the king" do
    end
  end # describe '#find_king'
end
