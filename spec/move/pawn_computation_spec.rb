require './lib/move/pawn_computation'

RSpec.describe PawnComputation do
  context "when the move is for white and is not a capture" do
    context "when the target square rank is 4" do
      it "returns the two squares right below the target square" do
        data = { target: { f: 'a', r: 4 }, color: Piece::WH }
        exp_start_squares = [{ f: 'a', r: 3 }, { f: 'a', r: 2 }]

        start_squares = PawnComputation::MOVE.call(data)
        expect(start_squares).to eq(exp_start_squares)
      end
    end

    context "when the target square rank is not 4" do
      it "returns the square right below the target square" do
        data = { target: { f: 'a', r: 3 }, color: Piece::WH }
        exp_start_square = [{ f: 'a', r: 2 }]

        start_square = PawnComputation::MOVE.call(data)
        expect(start_square).to eq(exp_start_square)
      end
    end
  end

  context "when the move is for white and is a capture" do
    it "returns the square right below the target at the specified file" do
      data = { target: { f: 'a', r: 3 }, color: Piece::WH, start_f: 'b' }
      exp_start_square = [{ f: 'b', r: 2 }]

      start_square = PawnComputation::CAPTURE.call(data)
      expect(start_square).to eq(exp_start_square)
    end
  end

  context "when the move is for black and is not a capture" do
    context "when the target square rank is 5" do
      it "returns the square right above the target square" do
        data = { target: { f: 'a', r: 5 }, color: Piece::BL }
        exp_start_square = [{ f: 'a', r: 6 }, { f: 'a', r: 7 }]

        start_square = PawnComputation::MOVE.call(data)
        expect(start_square).to eq(exp_start_square)
      end
    end

    context "when the target square rank is not 5" do
      it "returns the square right above the target square" do
        data = { target: { f: 'a', r: 6 }, color: Piece::BL }
        exp_start_square = [{ f: 'a', r: 7 }]

        start_square = PawnComputation::MOVE.call(data)
        expect(start_square).to eq(exp_start_square)
      end
    end
  end

  context "when the move is for black and is a capture" do
    it "returns the square right below the target at the specified file" do
      data = { target: { f: 'a', r: 6 }, color: Piece::BL, start_f: 'b' }
      exp_start_square = [{ f: 'b', r: 7 }]

      start_square = PawnComputation::CAPTURE.call(data)
      expect(start_square).to eq(exp_start_square)
    end
  end
end
