require './lib/move/judge/move_judge'
require './lib/move/pawn_move'
require './lib/board/board'
require './lib/standard/chess_piece'


RSpec.describe MoveJudge do
  describe '#check_target' do
    context "when the target square is to be empty" do
      context "when the target square is empty" do
        subject(:judge) { described_class.new }

        it "returns true" do
          target_square = { file: 'a', rank: 1 }

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return(nil)

          result = judge.check_target(target_square, board)
          expect(result).to be_truthy
        end
      end

      context "when the target square is not empty" do
        subject(:judge) { described_class.new }

        it "returns false" do
          target_square = { file: 'a', rank: 1 }

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return('a chess piece')

          result = judge.check_target(target_square, board)
          expect(result).to be_falsey
        end
      end
    end # context "when the target square is to be empty"

    context "when the target is specified" do
      context "when the the target square is empty" do
        subject(:judge) { described_class.new }

        it "returns false" do
          target_square = { file: 'a', rank: 1 }
          target = { type: ChessPiece::PA, color: ChessPiece::WH }

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return(nil)

          result = judge.check_target(target_square, board, target)
          expect(result).to be_falsey
        end
      end

      context "when the target square has the target" do
        subject(:judge) { described_class.new }

        it "returns true" do
          target_square = { file: 'a', rank: 1 }
          target = { type: ChessPiece::PA, color: ChessPiece::WH }

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return({ type: ChessPiece::PA, color: ChessPiece::WH })

          result = judge.check_target(target_square, board, target)
          expect(result).to be_truthy
        end
      end

      context "when the target square has a chess piece other than the target" do
        subject(:judge) { described_class.new }

        it "returns false" do
          target_square = { file: 'a', rank: 1 }
          target = { type: ChessPiece::PA, color: ChessPiece::BL }

          board = instance_double(Board)
          allow(board).to receive(:at).with('a', 1).and_return({ type: ChessPiece::PA, color: ChessPiece::WH })

          result = judge.check_target(target_square, board, target)
          expect(result).to be_falsey
        end
      end
    end # context "when the target square must have a chess piece of the specified color"
  end # describe '#check_target'


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
