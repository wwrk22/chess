require './lib/board/board'

require './lib/move/executor/castler'

require './lib/piece/bishop'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe Castler do
  subject(:castler) { described_class.new }

  describe '#clear_path?' do
    context "when white castles kingside" do
      context "when path is clear" do
        it "returns true" do
          board = Board.new
          castle = '0-0'

          result = castler.clear_path? castle, white, board

          expect(result).to eq(true)
        end
      end

      context "when path is not clear" do
        it "returns false" do
          board = Board.new
          board.set({ file: 'f', rank: 1 }, Bishop.new(white))
          castle = '0-0'

          result = castler.clear_path? castle, white, board

          expect(result).to eq(false)
        end
      end
    end # context "when white castles kingside"

    context "when white castles queenside" do
      context "when path is clear" do
        it "returns true" do
          board = Board.new
          castle = '0-0-0'

          result = castler.clear_path? castle, white, board

          expect(result).to eq(true)
        end
      end

      context "when path is not clear" do
        it "returns false" do
          board = Board.new
          board.set({ file: 'c', rank: 1 }, Bishop.new(white))
          castle = '0-0-0'

          result = castler.clear_path? castle, white, board

          expect(result).to eq(false)
        end
      end
    end # context "when white castles queenside"

    context "when black castles kingside" do
      context "when path is clear" do
        it "returns true" do
          board = Board.new
          castle = '0-0'

          result = castler.clear_path? castle, black, board

          expect(result).to eq(true)
        end
      end

      context "when path is not clear" do
        it "returns false" do
          board = Board.new
          board.set({ file: 'f', rank: 8 }, Bishop.new(black))
          castle = '0-0'

          result = castler.clear_path? castle, black, board

          expect(result).to eq(false)
        end
      end
    end # context "when black castles kingside"

    context "when black castles queenside" do
      context "when path is clear" do
        it "returns true" do
          board = Board.new
          castle = '0-0-0'

          result = castler.clear_path? castle, black, board

          expect(result).to eq(true)
        end
      end

      context "when path is not clear" do
        it "returns false" do
          board = Board.new
          board.set({ file: 'c', rank: 8 }, Bishop.new(black))
          castle = '0-0-0'

          result = castler.clear_path? castle, black, board

          expect(result).to eq(false)
        end
      end
    end # context "when black castles queenside"
  end # describe '#clear_path?'
end
