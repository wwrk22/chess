require './lib/board/board'

require './lib/move/executor/castler'

require './lib/piece/piece_specs'
require './lib/piece/bishop'
require './lib/piece/pawn'
require './lib/piece/king'
require './lib/piece/rook'
require './lib/piece/knight'
require './lib/piece/queen'


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


  describe '#checked_path?' do
    context "when checking white kingside path" do
      context "when there is a check by pawn" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 2 }, Pawn.new(black))

          result = castler.checked_path?('0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by knight" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'h', rank: 3 }, Knight.new(black))

          result = castler.checked_path?('0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by rook" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 5 }, Rook.new(black))

          result = castler.checked_path?('0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by bishop" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'c', rank: 5 }, Bishop.new(black))

          result = castler.checked_path?('0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by queen" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'g', rank: 8 }, Queen.new(black))

          result = castler.checked_path?('0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by king" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 2 }, King.new(black))

          result = castler.checked_path?('0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is no check" do
        it "returns false" do
          board = Board.new

          result = castler.checked_path?('0-0', white, board)
          expect(result).to eq(false)
        end
      end
    end # context "when checking white kingside path"

    context "when checking white queenside path" do
      context "when there is a check by pawn" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 2 }, Pawn.new(black))

          result = castler.checked_path?('0-0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by knight" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'b', rank: 3 }, Knight.new(black))

          result = castler.checked_path?('0-0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by rook" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'a', rank: 1 }, Rook.new(black))

          result = castler.checked_path?('0-0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by bishop" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'a', rank: 3 }, Bishop.new(black))

          result = castler.checked_path?('0-0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by queen" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'g', rank: 4 }, Queen.new(black))

          result = castler.checked_path?('0-0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by king" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'f', rank: 1 }, King.new(black))

          result = castler.checked_path?('0-0-0', white, board)
          expect(result).to eq(true)
        end
      end

      context "when there is no check" do
        it "returns false" do
          board = Board.new

          result = castler.checked_path?('0-0-0', white, board)
          expect(result).to eq(false)
        end
      end
    end # context "when checking white queenside path"

    context "when checking black kingside path" do
      context "when there is a check by pawn" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 7 }, Pawn.new(white))

          result = castler.checked_path?('0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by knight" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'h', rank: 6 }, Knight.new(white))

          result = castler.checked_path?('0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by rook" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 5 }, Rook.new(white))

          result = castler.checked_path?('0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by bishop" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'c', rank: 5 }, Bishop.new(white))

          result = castler.checked_path?('0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by queen" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'g', rank: 8 }, Queen.new(white))

          result = castler.checked_path?('0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by king" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'f', rank: 7 }, King.new(white))

          result = castler.checked_path?('0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is no check" do
        it "returns false" do
          board = Board.new

          result = castler.checked_path?('0-0', black, board)
          expect(result).to eq(false)
        end
      end
    end # context "when checking black kingside path"

    context "when checking black queenside path" do
      context "when there is a check by pawn" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'e', rank: 7 }, Pawn.new(white))

          result = castler.checked_path?('0-0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by knight" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'b', rank: 6 }, Knight.new(white))

          result = castler.checked_path?('0-0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by rook" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'a', rank: 8 }, Rook.new(white))

          result = castler.checked_path?('0-0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by bishop" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'a', rank: 5 }, Bishop.new(white))

          result = castler.checked_path?('0-0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by queen" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'g', rank: 4 }, Queen.new(white))

          result = castler.checked_path?('0-0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is a check by king" do
        it "returns true" do
          board = Board.new
          board.set({ file: 'c', rank: 8 }, King.new(white))

          result = castler.checked_path?('0-0-0', black, board)
          expect(result).to eq(true)
        end
      end

      context "when there is no check" do
        it "returns false" do
          board = Board.new

          result = castler.checked_path?('0-0-0', black, board)
          expect(result).to eq(false)
        end
      end
    end # context "when checking black queenside path"
  end # describe '#checked_path'


  describe '#do_castle' do
    context "when white castles kingside" do
      context "when all castling criteria are satisfied" do
        it "executes the move then returns true" do
          move = Move.new('0-0', white)

          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'h', rank: 1 }, Rook.new(white))

          result = castler.do_castle(move, white, board)
          expect(result).to eq(true)
        end
      end

      context "when the king has already moved at least once" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0', white)

          moved_king = King.new(white)
          moved_king.made_first_move = true

          board = Board.new
          board.set({ file: 'e', rank: 3 }, moved_king)
          board.set({ file: 'h', rank: 1 }, Rook.new(white))

          result = castler.do_castle(move, white, board)
          expect(result).to eq(false)
        end
      end

      context "when the king's castling path is blocked" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0', white)

          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'h', rank: 1 }, Rook.new(white))
          board.set({ file: 'f', rank: 1 }, Bishop.new(white))
          
          result = castler.do_castle(move, white, board)
          expect(result).to eq(false)
        end
      end

      context "when the king could be in check on one of the castling squares" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0', white)

          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'h', rank: 1 }, Rook.new(white))
          board.set({ file: 'f', rank: 5 }, Rook.new(black))

          result = castler.do_castle(move, white, board)
          expect(result).to eq(false)
        end
      end
    end # context "when white castles kingside"

    context "when white castles queenside" do
      context "when all castling criteria are satisfied" do
        it "executes the move then returns true" do
          move = Move.new('0-0-0', white)

          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'a', rank: 1 }, Rook.new(white))

          result = castler.do_castle(move, white, board)
          expect(result).to eq(true)
        end
      end

      context "when the king has already moved at least once" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0-0', white)

          moved_king = King.new(white)
          moved_king.made_first_move = true

          board = Board.new
          board.set({ file: 'e', rank: 3 }, moved_king)
          board.set({ file: 'a', rank: 1 }, Rook.new(white))

          result = castler.do_castle(move, white, board)
          expect(result).to eq(false)
        end
      end

      context "when the king's castling path is blocked" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0-0', white)

          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'a', rank: 1 }, Rook.new(white))
          board.set({ file: 'd', rank: 1 }, Queen.new(white))
          
          result = castler.do_castle(move, white, board)
          expect(result).to eq(false)
        end
      end

      context "when the king could be in check on one of the castling squares" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0-0', white)

          board = Board.new
          board.set({ file: 'e', rank: 1 }, King.new(white))
          board.set({ file: 'a', rank: 1 }, Rook.new(white))
          board.set({ file: 'b', rank: 2 }, Pawn.new(black))

          result = castler.do_castle(move, white, board)
          expect(result).to eq(false)
        end
      end
    end # context "when white castles queenside"

    context "when black castles kingside" do
      context "when all castling criteria are satisfied" do
        it "executes the move then returns true" do
          move = Move.new('0-0', black)

          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'h', rank: 8 }, Rook.new(black))

          result = castler.do_castle(move, black, board)
          expect(result).to eq(true)
        end
      end

      context "when the king has already moved at least once" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0', black)

          moved_king = King.new(black)
          moved_king.made_first_move = true

          board = Board.new
          board.set({ file: 'e', rank: 3 }, moved_king)
          board.set({ file: 'h', rank: 8 }, Rook.new(black))

          result = castler.do_castle(move, black, board)
          expect(result).to eq(false)
        end
      end

      context "when the king's castling path is blocked" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0', black)

          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'h', rank: 8 }, Rook.new(black))
          board.set({ file: 'f', rank: 8 }, Bishop.new(black))
          
          result = castler.do_castle(move, black, board)
          expect(result).to eq(false)
        end
      end

      context "when the king could be in check on one of the castling squares" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0', black)

          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'h', rank: 8 }, Rook.new(black))
          board.set({ file: 'h', rank: 7 }, Knight.new(white))

          result = castler.do_castle(move, black, board)
          expect(result).to eq(false)
        end
      end
    end # context "when black castles kingside"

    context "when black castles queenside" do
      context "when all castling criteria are satisfied" do
        it "executes the move then returns true" do
          move = Move.new('0-0-0', black)

          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'a', rank: 8 }, Rook.new(black))

          result = castler.do_castle(move, black, board)
          expect(result).to eq(true)
        end
      end

      context "when the king has already moved at least once" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0-0', black)

          moved_king = King.new(black)
          moved_king.made_first_move = true

          board = Board.new
          board.set({ file: 'e', rank: 3 }, moved_king)
          board.set({ file: 'a', rank: 8 }, Rook.new(black))

          result = castler.do_castle(move, black, board)
          expect(result).to eq(false)
        end
      end

      context "when the king's castling path is blocked" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0-0', black)

          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'a', rank: 8 }, Rook.new(black))
          board.set({ file: 'd', rank: 8 }, Queen.new(black))
          
          result = castler.do_castle(move, black, board)
          expect(result).to eq(false)
        end
      end

      context "when the king could be in check on one of the castling squares" do
        it "does not execute the move and returns false" do
          move = Move.new('0-0-0', black)

          board = Board.new
          board.set({ file: 'e', rank: 8 }, King.new(black))
          board.set({ file: 'a', rank: 8 }, Rook.new(black))
          board.set({ file: 'c', rank: 7 }, Pawn.new(white))

          result = castler.do_castle(move, black, board)
          expect(result).to eq(false)
        end
      end
    end # context "when black castles queenside"
  end # describe '#do_castle'
end
