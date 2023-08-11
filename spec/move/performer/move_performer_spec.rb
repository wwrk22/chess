require './lib/move/performer/move_performer'
require './lib/move/move'

require './lib/board/board'

require './lib/piece/piece_specs'
require './lib/piece/pawn'
require './lib/piece/rook'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe MovePerformer do  
  subject(:performer) { described_class.new }

  describe '#do_move' do
    context "when move is not a capture" do
      context "when the move can be made" do
        it "returns true" do
          move = Move.new('R1a5', white)
          move.target = { file: 'a', rank: 5 }
          move.start_coordinate = 1
          move.start = { file: 'a', rank: 1 }
          move.piece = Rook.new(white)

          board = Board.new
          board.set({ file: 'a', rank: 1 }, move.piece)

          result = performer.do_move(move, board)
          expect(result).to eq(true)
        end
      end # context "when the move can be made"

      context "when the move cannot be made" do
        it "returns false" do
          move = Move.new('Rad3', black)
          move.target = { file: 'd', rank: 3 }
          move.start_coordinate = 'a'
          move.start = { file: 'a', rank: 3 }
          move.piece = Rook.new(black)

          board = Board.new
          board.set({ file: 'a', rank: 3 }, move.piece)
          board.set({ file: 'd', rank: 3 }, Rook.new(white))

          result = performer.do_move(move, board)
          expect(result).to eq(false)
        end
      end # context "when the move cannot be made"
    end # context "when move is not a capture"

    context "when move is a capture" do
      context "when the move can be made" do
        it "returns true" do
          move = Move.new('R1a5', white, true)
          move.target = { file: 'a', rank: 5 }
          move.start_coordinate = 1
          move.start = { file: 'a', rank: 1 }
          move.piece = Rook.new(white)

          board = Board.new
          board.set({ file: 'a', rank: 1 }, move.piece)
          board.set({ file: 'a', rank: 5 }, Rook.new(black))

          result = performer.do_move(move, board)
          expect(result).to eq(true)
        end
      end # context "when the move can be made"

      context "when the move cannot be made" do
        it "returns true" do
          move = Move.new('R8a3', black, true)
          move.target = { file: 'a', rank: 3 }
          move.start_coordinate = 8
          move.start = { file: 'a', rank: 8 }
          move.piece = Rook.new(black)

          board = Board.new
          board.set({ file: 'a', rank: 8 }, move.piece)

          result = performer.do_move(move, board)
          expect(result).to eq(false)
        end
      end # context "when the move cannot be made"

      context "when the move is an en passant" do
        context "when the move can be made" do
          it "returns true" do
            move = Move.new('bxa6', white, true)
            move.ep = true
            move.ep_sq = { file: 'a', rank: 5 }
            move.target = { file: 'a', rank: 6 }
            move.start_coordinate = 'b'
            move.start = { file: 'b', rank: 5 }
            move.piece = Pawn.new(white)

            board = Board.new
            board.set({ file: 'b', rank: 5 }, move.piece)
            board.set({ file: 'a', rank: 5 }, Pawn.new(black))

            result = performer.do_move(move, board)
            expect(result).to eq(true)
          end
        end # context "when the move can be made"

        context "when the move cannot be made" do
          it "returns false" do
            move = Move.new('bxa3', black, true)
            move.ep = true
            move.ep_sq = { file: 'a', rank: 4 }
            move.target = { file: 'a', rank: 3 }
            move.start_coordinate = 'b'
            move.start = { file: 'b', rank: 4 }
            move.piece = Pawn.new(black)

            board = Board.new
            board.set({ file: 'b', rank: 4 }, move.piece)

            result = performer.do_move(move, board)
            expect(result).to eq(false)
          end
        end # context "when the move cannot be made"
      end # context "when the move is an en passant"
    end # context "when move is a capture"
  end
end
