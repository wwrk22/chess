require './lib/move/computer/start_computer'
require './lib/piece/piece_specs'
require './lib/board/board'
require './lib/piece/chess_piece'
require './lib/move/move'


RSpec.configure do |cfg|
  cfg.include PieceSpecs
end

RSpec.describe StartComputer do
  describe '#check_start' do
    subject(:computer) { described_class.new }

    it "checks the board to see if the chess piece is on the starting square" do
      board = instance_double(Board)
      start_square = { file: 'a', rank: 1 }
      white_rook = instance_double(ChessPiece)

      allow(board).to receive(:at).with(start_square[:file], start_square[:rank]).and_return(white_rook)

      allow(white_rook).to receive(:type).and_return(rook)
      allow(white_rook).to receive(:color).and_return(white)

      result = computer.check_start(start_square, white_rook, board)
      expect(result).to be_truthy
    end
  end # describe '#check_start'


  describe '#check_path' do
    subject(:computer) { described_class.new }

    let(:move) { instance_double(Move) }
    let(:board) { instance_double(Board) }
    let(:white_rook) { ChessPiece.new(rook, white) }
    let(:direction) { { file: 0, rank: -1 } }

    before do
      allow(move).to receive(:target).and_return({ file: 'a', rank: 3 })
      allow(move).to receive(:piece).and_return(white_rook)
    end

    context "when the piece is on the path and can get to the target square" do
      it "returns the square that the piece is on" do
        allow(board).to receive(:at).with('a', 2).and_return nil
        allow(board).to receive(:at).with('a', 1).and_return white_rook

        result = computer.check_path(move, board, direction)
        expected = { file: 'a', rank: 1 }
        expect(result).to eq(expected)
      end
    end

    context "when the piece is on the path but cannot get to the target square" do
      it "returns nil" do
        allow(board).to receive(:at).with('a', 2).and_return ChessPiece.new(pawn, white)
        
        result = computer.check_path(move, board, direction)
        expect(result).to be_nil
      end
    end

    context "when the piece is not on the path" do
      it "returns nil" do
        allow(board).to receive(:at).with('a', 2).and_return nil
        allow(board).to receive(:at).with('a', 1).and_return nil
        
        result = computer.check_path(move, board, direction)
        expect(result).to be_nil
      end
    end
  end # describe '#check_path'


  describe '#check_multiple_paths' do
    subject(:computer) { described_class.new }

    let(:move) { instance_double(Move) }
    let(:board) { instance_double(Board) }

    before do
      allow(move).to receive(:target).and_return({ file: 'd', rank: 4 })
      allow(move).to receive(:piece).and_return ChessPiece.new(rook, white)
    end

    context "when only one path returns a starting square" do
      it "returns that one starting square" do
        directions = [{ file: 0, rank: 1 }, { file: 1, rank: 0 },
                      { file: 0, rank: -1 }, { file: -1, rank: 0 }]
        expected = { file: 'a', rank: 4 }

        directions.each_with_index do |direction, index|
          return_value = (index == 0) ? { file: 'a', rank: 4 } : nil
          allow(computer).to receive(:check_path).with(move, board, direction).and_return return_value
        end

        result = computer.check_multiple_paths(move, board, directions)
        expect(result).to eq(expected)
      end
    end

    context "when two paths return a starting square" do
      it "returns nil" do
        directions = [{ file: 0, rank: 1 }, { file: 1, rank: 0 },
                      { file: 0, rank: -1 }, { file: -1, rank: 0 }]

        allow(computer).to receive(:check_path).with(move, board, directions[0]).and_return({ file: 'd', rank: 7 })
        allow(computer).to receive(:check_path).with(move, board, directions[1]).and_return({ file: 'f', rank: 4 })
        allow(computer).to receive(:check_path).with(move, board, directions[2]).and_return nil
        allow(computer).to receive(:check_path).with(move, board, directions[3]).and_return nil

        result = computer.check_multiple_paths(move, board, directions)
        expect(result).to be_nil
      end
    end

    context "when none of the paths return a starting square" do
      it "returns nil" do
        directions = [{ file: 0, rank: 1 }, { file: 1, rank: 0 },
                      { file: 0, rank: -1 }, { file: -1, rank: 0 }]

        directions.each_with_index do |direction, index|
          allow(computer).to receive(:check_path).with(move, board, direction).and_return nil
        end

        result = computer.check_multiple_paths(move, board, directions)
        expect(result).to be_nil
      end
    end
  end # describe '#check_multiple_paths'


  describe '#valid_start?' do
    subject(:computer) { described_class.new }

    let!(:target_square) { { file: 'a', rank: 5 } }
    let!(:start_square) { { file: 'a', rank: 1 } }
    let!(:moving_piece) { ChessPiece.new(rook, white) }
    let!(:board) { instance_double(Board) }
    let!(:move) { instance_double(Move) }

    before do
      allow(move).to receive(:piece).and_return moving_piece
      allow(move).to receive(:target).and_return target_square
    end

    context "when the starting square does not have the moving piece" do
      it "returns false" do
        allow(board).to receive(:at).with(start_square[:file], start_square[:rank]).and_return nil

        result = computer.valid_start? move, board, start_square
        expect(result).to be_falsey
      end
    end

    context "when the starting square has the moving piece" do
      context "when the path to the target square is not clear" do
        it "returns false" do
          allow(board).to receive(:at).with(start_square[:file], start_square[:rank]).and_return moving_piece

          direction = { file: 0, rank: -1 }
          allow(computer).to receive(:check_path).with(move, board, direction, start_square).and_return false

          result = computer.valid_start? move, board, start_square
          expect(result).to be_falsey
        end
      end

      context "when the path to the target square is clear" do
        it "returns false" do
          allow(board).to receive(:at).with(start_square[:file], start_square[:rank]).and_return moving_piece

          direction = { file: 0, rank: -1 }
          allow(computer).to receive(:check_path).with(move, board, direction, start_square).and_return true

          result = computer.valid_start? move, board, start_square
          expect(result).to be_truthy
        end
      end
    end # context "when the starting square has the moving piece"
  end # describe '#valid_start?'
end
