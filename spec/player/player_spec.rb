require './lib/player/player'

RSpec.describe Player do
  describe '#prompt_move' do
    let!(:valid_move) { 'a3' }
    let!(:color) { 'wh' }
    subject(:player) { described_class.new('player', color) }

    it "returns a hash of the move and the player color" do
      allow(player).to receive(:gets).and_return(valid_move)
      exp_out = { move: valid_move, color: color }
      expect(player.prompt_move).to eq(exp_out)
    end
  end # #prompt_move
end
