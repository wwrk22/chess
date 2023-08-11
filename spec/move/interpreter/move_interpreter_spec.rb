require './lib/board/board'
require './lib/board/board_specs'
require './lib/move/interpreter/move_interpreter'
require './lib/piece/chess_piece'
require './lib/piece/pawn'
require './lib/piece/piece_specs'
require './lib/move/move'
require 'move_samples'
require_relative 'test_moves'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
  cfg.include BoardSpecs
end

RSpec.describe MoveInterpreter do
  subject(:interpreter) { described_class.new }
      
  describe '#parse_target' do
    context "when move is a check or checkmate" do
      it "returns true" do
        move = 'bxa3+'
        target = interpreter.parse_target(move)
        expect(target).to eq({ file: 'a', rank: 3 })
      end
    end

    context "when move is not a check or checkmate" do
      it "returns true" do
        move = 'Nba3'
        target = interpreter.parse_target(move)
        expect(target).to eq({ file: 'a', rank: 3 })
      end
    end

    context "when parsing all possible move types" do
      it "returns the correct target square" do
        expected = { file: 'a', rank: 3 }

        result = MoveSamples::MOVES.all? do |move|
          interpreter.parse_target(move) == expected
        end

        expect(result).to eq(true)
      end
    end
  end # describe '#parse_target'

  describe '#capture?' do
    context "when move is a capture" do
      context "when move is a check or checkmate" do
        it "returns true" do
          move = 'bxa3+'
          expect(interpreter.capture? move).to eq(true)
        end
      end

      context "when move is not a check or checkmate" do
        it "returns false" do
          move = 'bxa3'
          expect(interpreter.capture? move).to eq(true)
        end
      end
    end

    context "when move is not a capture" do
      context "when move is a check or checkmate" do
        it "returns true" do
          move = 'Nba3#'
          expect(interpreter.capture? move).to eq(false)
        end
      end

      context "when move is not a check or checkmate" do
        it "returns false" do
          move = 'Nba3'
          expect(interpreter.capture? move).to eq(false)
        end
      end

      context "when move is a castle" do
        it "returns false" do
          move = '0-0'
          expect(interpreter.capture? move).to eq(false)
        end
      end
    end # context "when move is not a capture"
  end # describe '#capture?'

  describe '#parse_start_coordinate' do
    context "when move is for a pawn" do
      let!(:move) { instance_double(Move) }

      before do
        allow(move).to receive(:str).and_return 'axb3'
        allow(move).to receive(:piece).and_return ChessPiece.new(pawn, white)
      end

      context "when the move is a capture" do
        it "returns the file or rank of the moving pawn" do
          allow(move).to receive(:capture).and_return true

          expect(interpreter.parse_start_coordinate(move)).to eq('a')
        end
      end

      context "when the move is not a capture" do
        it "returns nil" do
          allow(move).to receive(:capture).and_return false

          expect(interpreter.parse_start_coordinate(move)).to be_nil
        end
      end
    end # context "when move is for a pawn"

    context "when move is for a piece other than pawn and king" do
      let!(:move) { instance_double(Move) }

      before do
        allow(move).to receive(:piece).and_return ChessPiece.new(rook, black)
      end

      context "when the move includes a start coordinate" do
        context "when move is a capture" do
          it "returns the start coordinate" do
            allow(move).to receive(:str).and_return 'Raxd4'

            expect(interpreter.parse_start_coordinate(move)).to eq('a')
          end
        end

        context "when move is not a capture" do
          it "returns the start coordinate" do
            allow(move).to receive(:str).and_return 'R4a3'

            expect(interpreter.parse_start_coordinate(move)).to eq(4)
          end
        end
      end # context "when the move does not include a start coordinate"

      context "when testing all move types except castling" do
        it "returns the correct start coordinate" do
          result = TestMoves::MOVES.map do |move_str|
            move = Move.new(move_str, white)

            move.capture = true if move_str.include? 'x'

            # Piece type and color don't matter here.
            if valid_file? move_str[0]
              move.piece = ChessPiece.new(pawn, white)
            else
              move.piece = ChessPiece.new(rook, white)
            end

            interpreter.parse_start_coordinate(move)
          end

          expect(result).to eq TestMoves::START_COORDS
        end
      end # context "when testing all move types except castling"
    end # context "when move is for a piece other than pawn and king"
  end # describe '#parse_starting_square'


  describe '#determine_ep' do
    context "when white is making an en passant move" do
      # The en passant move that white is making.
      let!(:move) { Move.new('bxa6', white, true) }
      # The pawn double move that black is making.
      let!(:opp_last_move) { Move.new('a5', black) }
      let!(:board) { Board.new }

      before do
        move.target = { file: 'a', rank: 6 }
        move.start_coordinate = 'b'
        move.piece = Pawn.new(white)

        opp_last_move.target = { file: 'a', rank: 5 }
        opp_last_move.piece = Pawn.new(black)

        board.set({ file: 'a', rank: 5 }, opp_last_move.piece)
      end

      context "when black's last move was a pawn double on the same file white is capturing" do
        it "return true" do
          # Black moved two squares which allows white to do an en passant.
          opp_last_move.start = { file: 'a', rank: 7 }

          result = interpreter.determine_ep(move, opp_last_move, board)
          expected = { ep: true, ep_sq: { file: 'a', rank: 5 } }

          expect(result).to eq(expected)
        end
      end

      context "when black's last move was not a pawn double" do
        it "returns false" do
          opp_last_move.start = { file: 'a', rank: 7 }
          opp_last_move.target = { file: 'a', rank: 6 }
          
          board.set({ file: 'a', rank: 5 })
          board.set(opp_last_move.target, opp_last_move.piece)

          result = interpreter.determine_ep(move, opp_last_move, board)
          expected = { ep: false, ep_sq: nil }

          expect(result).to eq(expected)
        end
      end

      context "when black's last move was a pawn single to rank five of the same file" do
        it "returns false" do
          # Black moved one square which does not allow white to do an en passant.
          opp_last_move.start = { file: 'a', rank: 6 }

          result = interpreter.determine_ep(move, opp_last_move, board)
          expected = { ep: false, ep_sq: nil }

          expect(result).to eq(expected)
        end
      end
    end # context "when white is making an en passant move"

    context "when black is making an en passant move" do
      # The en passant move that white is making.
      let!(:move) { Move.new('bxa3', black, true) }
      # The pawn double move that black is making.
      let!(:opp_last_move) { Move.new('a4', white) }
      let!(:board) { Board.new }

      before do
        move.target = { file: 'a', rank: 3 }
        move.start_coordinate = 'b'
        move.piece = Pawn.new(black)

        opp_last_move.target = { file: 'a', rank: 4 }
        opp_last_move.piece = Pawn.new(white)

        board.set({ file: 'a', rank: 4 }, opp_last_move.piece)
      end

      context "when white's last move was a pawn double on the same file black is capturing" do
        it "return true" do
          # White moved two squares which allows black to do an en passant.
          opp_last_move.start = { file: 'a', rank: 2 }

          result = interpreter.determine_ep(move, opp_last_move, board)
          expected = { ep: true, ep_sq: { file: 'a', rank: 4 } }

          expect(result).to eq(expected)
        end
      end

      context "when white's last move was not a pawn double" do
        it "returns false" do
          opp_last_move.start = { file: 'a', rank: 2 }
          opp_last_move.target = { file: 'a', rank: 3 }

          board.set({ file: 'a', rank: 4 })
          board.set(opp_last_move.target, opp_last_move.piece)

          result = interpreter.determine_ep(move, opp_last_move, board)
          expected = { ep: false, ep_sq: nil }

          expect(result).to eq(expected)
        end
      end

      context "when white's last move was a pawn single to rank four of the same file" do
        it "returns false" do
          # White moved one square which does not allow black to do an en passant.
          opp_last_move.start = { file: 'a', rank: 3 }

          result = interpreter.determine_ep(move, opp_last_move, board)
          expected = { ep: false, ep_sq: nil }

          expect(result).to eq(expected)
        end
      end
    end # context "when black is making an en passant move"
  end # describe '#determine_ep'
end
