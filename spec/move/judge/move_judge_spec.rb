require './lib/move/judge/move_judge'
require './lib/move/pawn_move'
require './lib/board/board'
require './lib/standard/chess_piece'
require './lib/move/move'


RSpec.describe MoveJudge do
  describe '#judge_move' do
    subject(:judge) { described_class.new }

    context "when target square is not empty" do
      it "returns false" do
        move = Move.new
        move.start = { file: 'a', rank: 1 },
        move.target = { file: 'a', rank: 2 },
        move.piece = { type: ChessPiece::RO, color: ChessPiece::WH },
        move.clear_path_required = true

        board = instance_double(Board)
        target_file, target_rank = [move.target[:file], move.target[:rank]]
        allow(board).to receive(:at).with(target_file, target_rank).and_return('a chess piece')

        expect(judge.judge_move(move, board)).to be_falsey
      end
    end # context "when target square is not empty"

    context "when target square is empty" do

    end # context "when target square is empty"
  end # describe '#judge_move'


  describe '#check_square' do
    subject(:judge) { described_class.new }

    let!(:board) { instance_double(Board) }
    let!(:white_pawn) { { type: ChessPiece::PA, color: ChessPiece::WH } }
    let!(:black_pawn) { { type: ChessPiece::PA, color: ChessPiece::BL } }
    let!(:square) { { file: 'a', rank: 1 } }

    context "when looking for an empty square" do
      context "when the square is empty" do
        it "returns true" do
          allow(board).to receive(:at).with(square[:file], square[:rank]).and_return(nil)
          expect(judge.check_square(square, board)).to be_truthy
        end
      end

      context "when the square is not empty" do
        it "returns false" do
          allow(board).to receive(:at).with(square[:file], square[:rank]).and_return(white_pawn)
          expect(judge.check_square(square, board)).to be_falsey
        end
      end
    end # context "when looking for an empty square"

    context "when looking for any chess piece of a chosen color" do
      context "when the square has a chess piece of the chosen color" do
        it "returns true" do
          allow(board).to receive(:at).with(square[:file], square[:rank]).and_return(white_pawn)
          expect(judge.check_square(square, board, ChessPiece::WH)).to be_truthy
        end
      end

      context "when the square has a chess piece of the other color" do
        it "returns false" do
          allow(board).to receive(:at).with(square[:file], square[:rank]).and_return(black_pawn)
          expect(judge.check_square(square, board, ChessPiece::WH)).to be_falsey
        end
      end
    end # context "when looking for any chess piece of a chosen color"

    context "when looking for a chess piece of a chosen color and type" do
      context "when a chess piece of same color and type is found" do
        it "returns true" do
          allow(board).to receive(:at).with(square[:file], square[:rank]).and_return(white_pawn)
          expect(judge.check_square(square, board, ChessPiece::WH, ChessPiece::PA)).to be_truthy
        end
      end

      context "when a chess piece of both different color and type is found" do
        it "returns false" do
          black_knight = { type: ChessPiece::KN, color: ChessPiece::BL }
          allow(board).to receive(:at).with(square[:file], square[:rank]).and_return(black_knight)
          expect(judge.check_square(square, board, ChessPiece::WH, ChessPiece::PA)).to be_falsey
        end
      end

      context "when a chess piece of same color but different type is found" do
        it "returns false" do
          white_knight = { type: ChessPiece::KN, color: ChessPiece::WH }
          allow(board).to receive(:at).with(square[:file], square[:rank]).and_return(white_knight)
          expect(judge.check_square(square, board, ChessPiece::WH, ChessPiece::PA)).to be_falsey
        end
      end

      context "when a chess piece of different color but same type is found" do
        it "returns false" do
          allow(board).to receive(:at).with(square[:file], square[:rank]).and_return(black_pawn)
          expect(judge.check_square(square, board, ChessPiece::WH, ChessPiece::PA)).to be_falsey
        end
      end
    end # context "when looking for a chess piece of a chosen color and type"
  end # describe '#check_square'


  describe '#clear_path?' do
    subject(:judge) { described_class.new }

    context "when the direction does not lead to square b" do
      it "returns false" do
        a = { file: 'a', rank: 1 }
        b = { file: 'h', rank: 1 }
        direction = { file: 6, rank: 0 }
        board = instance_double(Board)

        result = judge.clear_path?(a, b, board, direction)
        expect(result).to be_falsey
      end
    end

    context "when the direction leads to square b" do
      context "when there are two squares on the path" do
        context "when the path is clear" do
          it "returns true" do
            a = { file: 'a', rank: 1 }
            b = { file: 'd', rank: 1 }
            direction = { file: 3, rank: 0 }
            board = instance_double(Board)
            allow(board).to receive(:at).with('c', 1).and_return(nil)
            allow(board).to receive(:at).with('b', 1).and_return(nil)

            result = judge.clear_path?(a, b, board, direction)
            expect(result).to be_truthy
          end
        end

        context "when the path is not clear" do
          it "returns false" do
            a = { file: 'a', rank: 1 }
            b = { file: 'd', rank: 1 }
            direction = { file: 3, rank: 0 }
            board = instance_double(Board)
            allow(board).to receive(:at).with('c', 1).and_return('a chess piece')

            result = judge.clear_path?(a, b, board, direction)
            expect(result).to be_falsey
          end
        end
      end # context "when there are two squares on the path"

      context "when there is one square on the path" do
        context "when the path is clear" do
          it "returns true" do
            a = { file: 'a', rank: 1 }
            b = { file: 'a', rank: 3 }
            direction = { file: 0, rank: 2 }
            board = instance_double(Board)
            allow(board).to receive(:at).with('a', 2).and_return(nil)

            result = judge.clear_path?(a, b, board, direction)
            expect(result).to be_truthy
          end
        end

        context "when the path is not clear" do
          it "returns false" do
            a = { file: 'a', rank: 1 }
            b = { file: 'a', rank: 3 }
            direction = { file: 0, rank: 2 }
            board = instance_double(Board)
            allow(board).to receive(:at).with('a', 2).and_return('a chess piece')

            result = judge.clear_path?(a, b, board, direction)
            expect(result).to be_falsey
          end
        end
      end # context "when there is one square on the path"

      context "when there are no squares on the path" do
        it "returns true" do
          a = { file: 'a', rank: 1 }
          b = { file: 'b', rank: 2 }
          direction = { file: 1, rank: 1 }
          board = instance_double(Board)

          result = judge.clear_path?(a, b, board, direction)
          expect(result).to be_truthy
        end
      end
    end # context "when the direction leads to square b"
  end # describe '#clear_path?'
end
