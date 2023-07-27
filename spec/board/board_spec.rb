require './lib/board/board'
require './lib/board/board_specs'
require './lib/error/invalid_square'


RSpec.configure do |cfg|
  cfg.include BoardSpecs
end

RSpec.describe Board do
  describe '#at' do
    context "when the square coordinates are out-of-range" do
      context "when the file is out-of-range" do
        subject(:board) { described_class.new }

        it "raises an InvalidSquare::FileError" do
          expect{ board.at('z', 5) }.to raise_error(InvalidSquare::FileError)
        end
      end

      context "when the rank is out-of-range" do
        subject(:board) { described_class.new }

        it "raises an InvalidSquare::RankError" do
          expect{ board.at('a', 10) }.to raise_error(InvalidSquare::RankError)
        end
      end

      context "when the both file and rank are out-of-range" do
        subject(:board) { described_class.new }

        it "raises an InvalidSquare::CoordinateError" do
          expect{ board.at('z', 10) }.to raise_error(InvalidSquare::CoordinatesError)
        end
      end
    end # context "when the square coordinates are out-of-range"

    context "when the square coordinates are in-range" do
      subject(:board) { described_class.new }

      it "returns whatever is on the square" do
        file = 'a'
        rank = 1

        expect(board.at(file, rank)).to be_nil # nil indicates an empty square
      end
    end
  end # describe '#at'


  describe '#format_square' do
    context "when the square is on file h" do
      subject(:board) { described_class.new }

      it "appends a newline to the formatted string" do
        formatted_square = board.format_square(nil, 7, 0)
        expect(formatted_square[-1]).to eq("\n")
      end
    end # context "when the square is on file h"

    context "when the square is empty" do
      context "when the file has an odd index and the rank has odd index" do
        subject(:board) { described_class.new }

        it "returns a black square" do
          formatted_square = board.format_square(nil, 1, 1)
          expect(formatted_square).to eq(black_square)
        end
      end

      context "when the file has an odd index and the rank has even index" do
        subject(:board) { described_class.new }

        it "returns a white square" do
          formatted_square = board.format_square(nil, 1, 0)
          expect(formatted_square).to eq(white_square)
        end
      end

      context "when the file has an even index and the rank has even index" do
        subject(:board) { described_class.new }

        it "returns a black square" do
          formatted_square = board.format_square(nil, 0, 0)
          expect(formatted_square).to eq(black_square)
        end
      end

      context "when the file has a even index and the rank has an odd index" do
        subject(:board) { described_class.new }

        it "returns a white square" do
          formatted_square = board.format_square(nil, 0, 1)
          expect(formatted_square).to eq(white_square)
        end
      end
    end # context "when the square is empty"

    context "when the square has a chess piece" do
      context "when the square is on file h" do
      end

      context "when the square is not on file h" do
      end
    end # context "when the square has a chess piece"
  end # describe '#format_square'
end
