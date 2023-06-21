require './lib/move/interpreter/pawn_move_interpreter'
require './lib/move/move'
require './lib/standards/piece'

RSpec.describe PawnMoveInterpreter do
  describe '#interpret' do
    context "when move is for white" do
      subject(:white_interpreter) { described_class.new(Piece::WH) }

      context "when move is not a capture" do
        context "when move is not a double" do
          it "computes the one starting square" do
            move = white_interpreter.interpret('a3')
            correct_starts = [{ f: 'a', r: 2 }]
            expect(move.starts).to eq(correct_starts)
          end
        end

        context "when move is a double" do
          it "computes the two starting squares" do
            move = white_interpreter.interpret('a4')
            correct_starts = [{ f: 'a', r: 3 }, { f: 'a', r: 2 }]
            expect(move.starts).to eq(correct_starts)
          end
        end
      end # context "when move is not a capture"

      context "when move is a capture" do
        it "computes the one starting square" do
          move = white_interpreter.interpret('bxa3')
          correct_starts = [{ f: 'b', r: 2 }]
          expect(move.starts).to eq(correct_starts)
        end
      end
    end # context "when move is for white"

    context "when move is for black" do
      subject(:black_interpreter) { described_class.new(Piece::BL) }

      context "when move is not a capture" do
        context "when move is not a double" do
          it "computes the one starting square" do
            move = black_interpreter.interpret('a6')
            correct_starts = [{ f: 'a', r: 7 }]
            expect(move.starts).to eq(correct_starts)
          end
        end

        context "when move is a double" do
          it "computes the two starting squares" do
            move = black_interpreter.interpret('a5')
            correct_starts = [{ f: 'a', r: 6 }, { f: 'a', r: 7 }]
            expect(move.starts).to eq(correct_starts)
          end
        end
      end # when move is not a capture"

      context "when move is a capture" do
        it "computes the one starting square" do
          move = black_interpreter.interpret('bxa6')
          correct_starts = [{ f: 'b', r: 7 }]
          expect(move.starts).to eq(correct_starts)
        end
      end
    end # context "when move is for black"

  end # describe #interpret
end
