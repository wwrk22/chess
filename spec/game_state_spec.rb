require './lib/game_state'
require './lib/piece/piece_specs'
require './lib/board/board'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe GameState do
  subject(:gs) { described_class.new }

  describe '#player_checked?' do
    context "when white is checked" do
      context "when pawn is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'd', rank: 2 }, Pawn.new(black))

          result = gs.player_checked?(white, board)
          expect(result).to eq(true)
        end
      end

      context "when rook is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'e', rank: 4 }, Rook.new(black))

          result = gs.player_checked?(white, board)
          expect(result).to eq(true)
        end
      end

      context "when knight is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'd', rank: 3 }, Knight.new(black))

          result = gs.player_checked?(white, board)
          expect(result).to eq(true)
        end
      end

      context "when bishop is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'b', rank: 4 }, Bishop.new(black))

          result = gs.player_checked?(white, board)
          expect(result).to eq(true)
        end
      end

      context "when queen is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'h', rank: 4 }, Queen.new(black))

          result = gs.player_checked?(white, board)
          expect(result).to eq(true)
        end
      end

      context "when king is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'e', rank: 2 }, King.new(black))

          result = gs.player_checked?(white, board)
          expect(result).to eq(true)
        end
      end
    end # context "when white is checked"

    context "when black is checked" do
      context "when pawn is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'd', rank: 7 }, Pawn.new(white))

          result = gs.player_checked?(black, board)
          expect(result).to eq(true)
        end
      end

      context "when rook is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'e', rank: 4 }, Rook.new(white))

          result = gs.player_checked?(black, board)
          expect(result).to eq(true)
        end
      end

      context "when knight is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'd', rank: 6 }, Knight.new(white))

          result = gs.player_checked?(black, board)
          expect(result).to eq(true)
        end
      end

      context "when bishop is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'b', rank: 5 }, Bishop.new(white))

          result = gs.player_checked?(black, board)
          expect(result).to eq(true)
        end
      end

      context "when queen is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'h', rank: 5 }, Queen.new(white))

          result = gs.player_checked?(black, board)
          expect(result).to eq(true)
        end
      end

      context "when king is checking" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'e', rank: 7 }, King.new(white))

          result = gs.player_checked?(black, board)
          expect(result).to eq(true)
        end
      end
    end # context "when black is checked"

    context "when there is no check" do
      it "returns false" do
        board = Board.new
        board.set({ file: 'e', rank: 1 }, King.new(white))
        board.set({ file: 'e', rank: 4 }, Rook.new(black))
        board.set({ file: 'e', rank: 2 }, Pawn.new(white))

        result = gs.player_checked?(white, board)
        expect(result).to eq(false)
      end
    end
  end # describe '#player_checked?'


  describe '#checkmate?' do
    context "when white is in a checkmate" do
      context "when queen and pawn checkmate" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'c', rank: 2 }, Queen.new(black))
          board.set({ file: 'g', rank: 2 }, Pawn.new(black))

          result = gs.checkmate?(white, board)
          expect(result).to eq(true)
        end
      end

      context "when two knights and a pawn checkmate" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'c', rank: 3 }, Knight.new(black))
          board.set({ file: 'g', rank: 3 }, Knight.new(black))
          board.set({ file: 'e', rank: 3 }, Pawn.new(black))

          result = gs.checkmate?(white, board)
          expect(result).to eq(true)
        end
      end
    end # context "when white is in a checkmate"

    context "when black is in a checkmate" do
      context "when queen and pawn checkmate" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'c', rank: 7 }, Queen.new(white))
          board.set({ file: 'g', rank: 7 }, Pawn.new(white))

          result = gs.checkmate?(black, board)
          expect(result).to eq(true)
        end
      end

      context "when two knights and a pawn checkmate" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'c', rank: 6 }, Knight.new(white))
          board.set({ file: 'g', rank: 6 }, Knight.new(white))
          board.set({ file: 'e', rank: 6 }, Pawn.new(white))

          result = gs.checkmate?(black, board)
          expect(result).to eq(true)
        end
      end
    end # context "when black is in a checkmate"
  end # describe '#checkmate?'
end
