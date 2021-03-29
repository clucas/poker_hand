require 'rails_helper'

RSpec.describe GameService do
  subject { described_class.instance }

  describe '#import_game' do
    let(:line) { 'QS 9C QD 6H JS 5D AC 8D 2S AS' }
    let(:game_file) {
      file = Tempfile.new('game')
      file.write(line)
      file.rewind
      file
    }

    it 'imports' do
      game = subject.import_game(game_file)
      expect(game.players.size).to eq(line.split(' ').size / Hand::NUMBER_OF_CARDS)
      expect(game.players.map(&:hands).map(&:all).map { |x| x.map(&:card_list) }.join(' ')).to eq line
    end
  end
end