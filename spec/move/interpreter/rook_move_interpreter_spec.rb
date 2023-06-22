require './lib/move/interpreter/rook_move_interpreter'
require './lib/standards/piece'
require './lib/standards/board_standards'
require './lib/board/board'

RSpec.describe RookMoveInterpreter do
  describe '#interpret' do
    subject(:interpreter) { described_class.new(Piece::WH) }
    let(:move) { instance_double(Move) }

    context "when neither start file nor rank is specified" do
      context "when the target is in the middle of the board" do
        before do
          file_d = Board.get_line('d')
          rank_4 = Board.get_line(4)
          @correct_starts = file_d.concat(rank_4)
          @correct_starts.delete({ f: 'd', r: 4 })

          data = { target: { f: 'd', r: 4 } }
          allow(move).to receive(:compute_starts).and_yield(data)
          allow(move).to receive(:starts=).with(@correct_starts)
          allow(Move).to receive(:new).and_return(move)
          allow(interpreter).to receive(:init_move)
        end

        it "selects all squares in the target file and rank except for the target square itself" do
          interpreted_move = interpreter.interpret('Rd4')

          starts = interpreted_move.instance_variable_get(:@starts)
          expect(starts).to eq(@correct_starts)
        end
      end

      context "when the target is a corner square" do
        context "when target square is a1" do
          before do
            data = { target: { f: 'a', r: 1 } }
            allow(move).to receive(:compute_starts).and_yield(data)
          end

          it "selects all squares above and to the right of the target on its file and rank respectively" do
            move = interpreter.interpret('Ra1')
            file_a = Board.get_line('a')
            rank_1 = Board.get_line(1)
            correct_starts = file_a.concat(rank_1)
            correct_starts.delete({ f: 'a', r: 1 })

            expect(move.starts).to eq(correct_starts)
          end
        end

        context "when target square is a8" do
          before do
            data = { target: { f: 'a', r: 8 } }
            allow(move).to receive(:compute_starts).and_yield(data)
          end

          it "selects all squares below and to the right of the target on its file and rank respectively" do
            move = interpreter.interpret('Ra8')
            file_a = Board.get_line('a')
            rank_8 = Board.get_line(8)
            correct_starts = file_a.concat(rank_8)
            correct_starts.delete({ f: 'a', r: 8 })

            expect(move.starts).to eq(correct_starts)
          end
        end

        context "when target square is h8" do
          before do
            data = { target: { f: 'h', r: 8 } }
            allow(move).to receive(:compute_starts).and_yield(data)
          end

          it "selects all squares below and to the left of the target on its file and rank respectively" do
            move = interpreter.interpret('Rh8')
            file_h = Board.get_line('h')
            rank_8 = Board.get_line(8)
            correct_starts = file_h.concat(rank_8)
            correct_starts.delete({ f: 'h', r: 8 })

            expect(move.starts).to eq(correct_starts)
          end
        end

        context "when target square is h1" do
          before do
            data = { target: { f: 'h', r: 1 } }
            allow(move).to receive(:compute_starts).and_yield(data)
          end

          it "selects all squares above and to the left of the target on its file and rank respectively" do
            move = interpreter.interpret('Rh1')
            file_h = Board.get_line('h')
            rank_1 = Board.get_line(1)
            correct_starts = file_h.concat(rank_1)
            correct_starts.delete({ f: 'h', r: 1 })

            expect(move.starts).to eq(correct_starts)
          end
        end
      end # context "when neither start file nor rank is specified"

      context "when the target is on a non-corner edge square" do
        context "when the square is d1" do
          before do
            data = { target: { f: 'd', r: 1 } }
            allow(move).to receive(:compute_starts).and_yield(data)
          end

          it "selects all squares in the file and rank of the target except for the target square itself" do
            move = interpreter.interpret('Rd1')
            file_d = Board.get_line('d')
            rank_1 = Board.get_line(1)
            correct_starts = file_d.concat(rank_1)
            correct_starts.delete({ f: 'd', r: 1 })

            expect(move.starts).to eq(correct_starts)
          end
        end

        context "when the square is a4" do
          before do
            data = { target: { f: 'a', r: 4 } }
            allow(move).to receive(:compute_starts).and_yield(data)
          end

          it "selects all squares in the file and rank of the target except for the target square itself" do
            interpreted_move = interpreter.interpret('Ra4')
            file_a = Board.get_line('a')
            rank_4 = Board.get_line(4)
            correct_starts = file_a.concat(rank_4)
            correct_starts.delete({ f: 'a', r: 4 })

            expect(interpreted_move.starts).to eq(correct_starts)
          end
        end

        context "when the square is d8" do
          it "selects all squares in the file and rank of the target except for the target square itself" do
            move = interpreter.interpret('Rd8')
            file_d = Board.get_line('d')
            rank_8 = Board.get_line(8)
            correct_starts = file_d.concat(rank_8)
            correct_starts.delete({ f: 'd', r: 8 })

            expect(move.starts).to eq(correct_starts)
          end
        end

        context "when the square is h4" do
          it "selects all squares in the file and rank of the target except for the target square itself" do
            move = interpreter.interpret('Rh4')
            file_h = Board.get_line('h')
            rank_4 = Board.get_line(4)
            correct_starts = file_h.concat(rank_4)
            correct_starts.delete({ f: 'h', r: 4 })

            expect(move.starts).to eq(correct_starts)
          end
        end
      end # context "when the target is on a non-corner edge square"
    end # context "when neither start file nor rank is specified"

    context "when start file is specified" do
      context "when start file is the same as target file" do
        it "selects all squares in the file as possible starts" do
          move = interpreter.interpret('Rdd4')
          correct_starts = (1..8).reduce([]) do |line, rank|
            line << { f: 'd', r: rank }
          end

          expect(move.starts).to eq(correct_starts)
        end
      end

      context "when start file is not the same as target file" do
        before do
          data = { target: { f: 'd', r: 4 }, piece: Piece::RO,
                   color: Piece::WH, capture: false, start_f: 'a' }
          allow(move).to receive(:compute_starts).and_yield(data)
        end

        it "computes the one starting square" do
          interpreted_move = interpreter.interpret('Rad4')
          correct_starts = [{ f: 'a', r: 4 }]
          expect(interpreted_move.starts).to eq(correct_starts)
        end
      end
    end # context "when start file is specified"

    context "when start rank is specified" do
      context "when start rank is the same as target rank" do
        it "selects all squares in the rank as possible starts" do
          move = interpreter.interpret('R4d4')
          correct_starts = BoardStandards::FILES.each_char.reduce([]) do |line, file|
            line << { f: file, r: 4 }
          end

          expect(move.starts).to eq(correct_starts)
        end
      end

      context "when start rank is not the same as target rank" do
        it "computes the one starting square" do
          move = interpreter.interpret('R2d4')
          correct_starts = [{ f: 'd', r: 2 }]
          expect(move.starts).to eq(correct_starts)
        end
      end
    end # context "when start rank is specified"

  end # describe '#interpret'
end
