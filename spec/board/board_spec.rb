require './lib/board/board'
require './lib/board/board_specs'
require './lib/error/invalid_square'
require './lib/piece/pawn'
require './lib/piece/piece_specs'


RSpec.configure do |cfg|
  cfg.include BoardSpecs
  cfg.include PieceSpecs
end

RSpec.describe Board do
  describe '#at' do
    context "when the square coordinates are out-of-range" do
      context "when the file is out-of-range" do
        subject(:board) { described_class.new }

        it "raises an InvalidSquare::FileError" do
          expect{ board.at({ file: 'z', rank: 5 }) }.to raise_error(InvalidSquare::FileError)
        end
      end

      context "when the rank is out-of-range" do
        subject(:board) { described_class.new }

        it "raises an InvalidSquare::RankError" do
          expect{ board.at({ file: 'a', rank: 10 }) }.to raise_error(InvalidSquare::RankError)
        end
      end

      context "when the both file and rank are out-of-range" do
        subject(:board) { described_class.new }

        it "raises an InvalidSquare::CoordinateError" do
          expect{ board.at({ file: 'z', rank: 10 }) }.to raise_error(InvalidSquare::CoordinatesError)
        end
      end
    end # context "when the square coordinates are out-of-range"

    context "when the square coordinates are in-range" do
      subject(:board) { described_class.new }

      it "returns whatever is on the square" do
        expect(board.at({ file: 'a', rank: 1 })).to be_nil # nil indicates an empty square
      end
    end
  end # describe '#at'


  describe '#format_square' do
    context "when the square is on file h" do
      subject(:board) { described_class.new }

      it "appends a newline to the formatted string" do
        formatted = board.format_square(nil, 7, 0)
        expect(formatted[-1]).to eq("\n")
      end
    end # context "when the square is on file h"

    context "when the square is empty" do
      context "when the file has an odd index and the rank has odd index" do
        subject(:board) { described_class.new }

        it "returns a black square" do
          formatted = board.format_square(nil, 1, 1)
          expect(formatted).to eq(black_square)
        end
      end

      context "when the file has an odd index and the rank has even index" do
        subject(:board) { described_class.new }

        it "returns a white square" do
          formatted = board.format_square(nil, 1, 0)
          expect(formatted).to eq(white_square)
        end
      end

      context "when the file has an even index and the rank has even index" do
        subject(:board) { described_class.new }

        it "returns a black square" do
          formatted = board.format_square(nil, 0, 0)
          expect(formatted).to eq(black_square)
        end
      end

      context "when the file has a even index and the rank has an odd index" do
        subject(:board) { described_class.new }

        it "returns a white square" do
          formatted = board.format_square(nil, 0, 1)
          expect(formatted).to eq(white_square)
        end
      end
    end # context "when the square is empty"
  end # describe '#format_square'


  describe '#format_piece' do
    subject(:board) { described_class.new }

    it "returns the unicode string of the given piece" do
      pawn = Pawn.new(white)
      formatted = board.format_piece(pawn, 0, 0)
      expect(formatted).to eq(Pawn.unicode_wh + ' ')
    end

    context "when the piece is on file h" do
      subject(:board) { described_class.new }

      it "appends a newline to the formatted string" do
        pawn = Pawn.new(white)
        formatted = board.format_piece(pawn, 7, 0)
        expect(formatted[-1]).to eq("\n")
      end
    end # context "when the piece is on file h"
  end # describe '#format_piece'


  describe '#search_king' do
    subject(:board) { described_class.new }

    context "when the king is not on the board" do
      it "returns false" do
        result = board.search_king(white)
        expect(result).to be_falsey
      end
    end

    context "when the king is on the board" do
      it "returns true" do
        ranks = board.instance_variable_get(:@ranks)
        ranks[0][0] = ChessPiece.new(king, white)

        result = board.search_king(white)
        expect(result).to be_truthy
      end
    end
  end
end
