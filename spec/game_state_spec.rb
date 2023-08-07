require './lib/game_state'
require './lib/board/board'
require './lib/piece/piece_specs'



RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe GameState do
  describe '#search_kings' do
    subject(:game_state) { described_class.new }

    it "returns a hash of values that tell whether or not either king is on the board" do
      board = instance_double(Board)
      king_count = { wh_king_found: 1, bl_king_found: 1 }
      white_king = { type: king, color: white }
      black_king = { type: king, color: black }

      allow(board).to receive(:search_king).with(white).and_return(1)
      allow(board).to receive(:search_king).with(black).and_return(1)

      expect(game_state.search_kings(board)).to eq(king_count)
    end
  end # describe '#search_kings'


  describe '#determine_winner' do
    subject(:game_state) { described_class.new }

    context "when both kings are found" do
      it "returns nil" do
        expect(game_state.determine_winner(1, 1)).to be_nil
      end
    end

    context "when only white king is found" do
      it "returns 'WH'" do
        expect(game_state.determine_winner(1, 0)).to eq(white)
      end
    end

    context "when only black king is found" do
      it "returns 'BL'" do
        expect(game_state.determine_winner(0, 1)).to eq(black)
      end
    end
  end # describe '#determine_winner'
end
