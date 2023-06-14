require './lib/player'

RSpec.describe Player do
  describe '#prompt_move' do
    context "when player color is white" do
      context "when move syntax is valid" do
        subject(:white_valid) { described_class.new('Foo', 'white')

        it "returns a hash of the move and the player's color" do
        end
      end

      context "when move syntax is invalid" do
      end
    end

    context "when player color is black" do
      context "when move syntax is valid" do
      end

      context "when move syntax is invalid" do
      end
    end
  end
end
