require './lib/board/board'

require './lib/move/executor/castler'

require './lib/piece/piece_specs'
require './lib/piece/bishop'
require './lib/piece/king'
require './lib/piece/rook'


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


  describe '#pieces_in_place?' do
    context "when white is castling kingside" do
      context "when both king and rook haven't moved" do
        it "returns true" do
          castle = '0-0'

          board = Board.new
          new_king = King.new(white)
          new_king.made_first_move = false
          new_rook = Rook.new(white)
          new_rook.made_first_move = false
          board.set({ file: 'e', rank: 1 }, new_king)
          board.set({ file: 'h', rank: 1 }, new_rook)

          result = castler.pieces_in_place? castle, white, board

          expect(result).to eq(true)
        end
      end

      context "when king has already moved" do
        it "returns false" do
          castle = '0-0'

          board = Board.new
          new_king = King.new(white)
          new_king.made_first_move = true
          new_rook = Rook.new(white)
          new_rook.made_first_move = false
          board.set({ file: 'e', rank: 2 }, new_king)
          board.set({ file: 'h', rank: 1 }, new_rook)

          result = castler.pieces_in_place? castle, white, board

          expect(result).to eq(false)
        end
      end

      context "when rook has already moved" do
        it "returns false" do
          castle = '0-0'

          board = Board.new
          new_king = King.new(white)
          new_king.made_first_move = false
          new_rook = Rook.new(white)
          new_rook.made_first_move = true
          board.set({ file: 'e', rank: 1 }, new_king)
          board.set({ file: 'h', rank: 5 }, new_rook)

          result = castler.pieces_in_place? castle, white, board

          expect(result).to eq(false)
        end
      end

      context "when both have already moved" do
        it "returns false" do
          castle = '0-0'

          board = Board.new
          new_king = King.new(white)
          new_king.made_first_move = true
          new_rook = Rook.new(white)
          new_rook.made_first_move = true
          board.set({ file: 'e', rank: 2 }, new_king)
          board.set({ file: 'h', rank: 5 }, new_rook)

          result = castler.pieces_in_place? castle, white, board

          expect(result).to eq(false)
        end
      end
    end # context "when white is castling kingside"

    context "when white is castling queenside" do
      context "when both king and rook haven't moved" do
        it "returns false" do
          castle = '0-0-0'

          board = Board.new
          new_king = King.new(white)
          new_king.made_first_move = false
          new_rook = Rook.new(white)
          new_rook.made_first_move = false
          board.set({ file: 'e', rank: 1 }, new_king)
          board.set({ file: 'h', rank: 1 }, new_rook)

          result = castler.pieces_in_place? castle, white, board

          expect(result).to eq(false)
        end
      end

      context "when king has already moved" do
        it "returns false" do
          castle = '0-0-0'

          board = Board.new
          new_king = King.new(white)
          new_king.made_first_move = true
          new_rook = Rook.new(white)
          new_rook.made_first_move = false
          board.set({ file: 'e', rank: 2 }, new_king)
          board.set({ file: 'a', rank: 1 }, new_rook)

          result = castler.pieces_in_place? castle, white, board

          expect(result).to eq(false)
        end
      end

      context "when rook has already moved" do
        it "returns false" do
          castle = '0-0-0'

          board = Board.new
          new_king = King.new(white)
          new_king.made_first_move = false
          new_rook = Rook.new(white)
          new_rook.made_first_move = true
          board.set({ file: 'e', rank: 1 }, new_king)
          board.set({ file: 'a', rank: 5 }, new_rook)

          result = castler.pieces_in_place? castle, white, board

          expect(result).to eq(false)
        end
      end

      context "when both have already moved" do
        it "returns false" do
          castle = '0-0-0'

          board = Board.new
          new_king = King.new(white)
          new_king.made_first_move = true
          new_rook = Rook.new(white)
          new_rook.made_first_move = true
          board.set({ file: 'e', rank: 2 }, new_king)
          board.set({ file: 'a', rank: 5 }, new_rook)

          result = castler.pieces_in_place? castle, white, board

          expect(result).to eq(false)
        end
      end
    end # context "when white is castling queenside"

    context "when black is castling kingside" do
      context "when both king and rook haven't moved" do
        it "returns true" do
          castle = '0-0'

          board = Board.new
          black_king = King.new(black)
          black_king.made_first_move = false
          black_rook = Rook.new(black)
          black_rook.made_first_move = false
          board.set({ file: 'e', rank: 8 }, black_king)
          board.set({ file: 'h', rank: 8 }, black_rook)

          result = castler.pieces_in_place? castle, black, board

          expect(result).to eq(true)
        end
      end

      context "when king has already moved" do
        it "returns false" do
          castle = '0-0'

          board = Board.new
          black_king = King.new(black)
          black_king.made_first_move = true
          black_rook = Rook.new(black)
          black_rook.made_first_move = false
          board.set({ file: 'e', rank: 7 }, black_king)
          board.set({ file: 'h', rank: 8 }, black_rook)

          result = castler.pieces_in_place? castle, black, board

          expect(result).to eq(false)
        end
      end

      context "when rook has already moved" do
        it "returns false" do
          castle = '0-0'

          board = Board.new
          black_king = King.new(black)
          black_king.made_first_move = false
          black_rook = Rook.new(black)
          black_rook.made_first_move = true
          board.set({ file: 'e', rank: 8 }, black_king)
          board.set({ file: 'h', rank: 7 }, black_rook)

          result = castler.pieces_in_place? castle, black, board

          expect(result).to eq(false)
        end
      end

      context "when both have already moved" do
        it "returns false" do
          castle = '0-0'

          board = Board.new
          black_king = King.new(black)
          black_king.made_first_move = true
          black_rook = Rook.new(black)
          black_rook.made_first_move = true
          board.set({ file: 'e', rank: 7 }, black_king)
          board.set({ file: 'h', rank: 7 }, black_rook)

          result = castler.pieces_in_place? castle, black, board

          expect(result).to eq(false)
        end
      end
    end # context "when black is castling kingside"

    context "when black is castling queenside" do
      context "when both king and rook haven't moved" do
        it "returns false" do
          castle = '0-0-0'

          board = Board.new
          black_king = King.new(black)
          black_king.made_first_move = false
          black_rook = Rook.new(black)
          black_rook.made_first_move = false
          board.set({ file: 'e', rank: 8 }, black_king)
          board.set({ file: 'a', rank: 8 }, black_rook)

          result = castler.pieces_in_place? castle, black, board

          expect(result).to eq(true)
        end
      end

      context "when king has already moved" do
        it "returns false" do
          castle = '0-0-0'

          board = Board.new
          black_king = King.new(black)
          black_king.made_first_move = true
          black_rook = Rook.new(black)
          black_rook.made_first_move = false
          board.set({ file: 'e', rank: 7 }, black_king)
          board.set({ file: 'a', rank: 8 }, black_rook)

          result = castler.pieces_in_place? castle, black, board

          expect(result).to eq(false)
        end
      end

      context "when rook has already moved" do
        it "returns false" do
          castle = '0-0-0'

          board = Board.new
          black_king = King.new(black)
          black_king.made_first_move = false
          black_rook = Rook.new(black)
          black_rook.made_first_move = true
          board.set({ file: 'e', rank: 8 }, black_king)
          board.set({ file: 'a', rank: 5 }, black_rook)

          result = castler.pieces_in_place? castle, black, board

          expect(result).to eq(false)
        end
      end

      context "when both have already moved" do
        it "returns false" do
          castle = '0-0-0'

          board = Board.new
          black_king = King.new(black)
          black_king.made_first_move = true
          black_rook = Rook.new(black)
          black_rook.made_first_move = true
          board.set({ file: 'e', rank: 7 }, black_king)
          board.set({ file: 'a', rank: 5 }, black_rook)

          result = castler.pieces_in_place? castle, black, board

          expect(result).to eq(false)
        end
      end
    end # context "when black is castling queenside"
  end # describe '#pieces_in_place?'
end
