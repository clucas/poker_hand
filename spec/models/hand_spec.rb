require 'rails_helper'

RSpec.describe Hand, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:player) }
    it { is_expected.to belong_to(:round) }
    it { is_expected.to have_one(:win) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:card_list) }
    it { is_expected.to validate_presence_of(:round) }
    it { is_expected.to validate_presence_of(:player) }
  end

  describe '#rank' do
    let(:game) { create :game, name: 'new_game'}
    let(:player) { create :player, game: game }
    let(:round) { create :round, game: game }

    context 'royal_flush' do
      let(:hand) { create :hand, card_list: 'TH JH QH KH AH', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:royal_flush, 'A']
      end
    end

    context 'straight_flush' do
      let(:hand) { create :hand, card_list: '5D 6D 7D 8D 9D', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:straight_flush, '9']
      end
    end

    context 'four_of_a_kind' do
      let(:hand) { create :hand, card_list: '8D 8H 8C 8D 9D', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:four_of_a_kind, ['8', '9']]
      end
    end

    context 'full_house' do
      let(:hand) { create :hand, card_list: '8D 8H 8C 9D 9S', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:full_house, ['8', '9']]
      end
    end

    context 'flush' do
      let(:hand) { create :hand, card_list: '8D 2D 7D TD KD', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:flush, 'K']
      end
    end

    context 'straight' do
      let(:hand) { create :hand, card_list: '7H 8S 9C TD JD', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:straight, 'J']
      end
    end

    context 'three_of_a_kind' do
      let(:hand) { create :hand, card_list: '9H 9S 9C TD JD', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:three_of_a_kind, ["9", "J", "T"]]
      end
    end

    context 'two_pairs' do
      let(:hand) { create :hand, card_list: '9H 9S TC TD JD', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:two_pairs, ["T", "9", "J"]]
      end
    end

    context 'one_pair' do
      let(:hand) { create :hand, card_list: 'TS 9H 6H 6D 8S', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:one_pair, ["6", "T", "9", "8"]]
      end
    end

    context 'high_card' do
      let(:hand) { create :hand, card_list: '3S 4H 9H TD QS', round: round, player: player }

      it 'detects' do
        expect(hand.rank).to eq [:high_card, 'Q']
      end
    end
  end
end
