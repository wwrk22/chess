require './lib/move/move'

RSpec.describe Move do
  describe '#compute_starts' do
    context "when all attributes except @starts are populated" do
      it "computes all possible starting squares to save in @starts, then returns true" do
      end
    end

    context "when not all attributes, except @starts, are populated" do
      it "does nothing and returns false" do
      end
    end
  end # describe #compute_starts
end
