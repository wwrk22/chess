require './lib/board/board'
require './lib/error/invalid_square'


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
end
