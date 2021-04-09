class Hand < ApplicationRecord
  belongs_to :player
  belongs_to :round
  has_one :win, dependent: :delete

  validates :number, presence: true
  validates :card_list, presence: true
  validates :round, presence: true
  validates :player, presence: true

  NUMBER_OF_CARDS = 5

  # rules for ranks
  RANKS = { royal_flush: { suits: 1, consecutive: 5, highest: 'A', card: 1 , rank: 10 },
            straight_flush: { suits: 1, consecutive: 5, card: 1, rank: 9 },
            four_of_a_kind: { values: [4], highest_max_card: 1, rank: 8 },
            full_house: { values: [3, 2], highest_max_card: 1, rank: 7 },
            flush: { suits: 1, card: 1, rank: 6 },
            straight: { consecutive: 5, card: 1, rank: 5 },
            three_of_a_kind: { values: [3], highest_max_card: 1, rank: 4 },
            two_pairs: { values: [2,2], highest_max_card: 1, rank: 3 },
            one_pair: { values: [2], highest_max_card: 1, rank: 2 },
            high_card: { card: 1, rank: 1 }
  }.freeze

  CARD_ORDER = HashWithIndifferentAccess.new(
    { '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9, 'T': 10, 'J': 11, 'Q': 12, 'K': 13, 'A': 14 }
  ).freeze

  # Detremine rank for hand
  def rank
    RANKS.each do |k,v|
      matching = match_rules(v)
      return [k, matching] if matching
    end
  end

  private

  # Initialize data for hand
  def hand_data
    h = { values: { max: [], list: {} }, suits: { max: 0, list: {} } }
    sorted_cards = self.card_list.split(' ').sort { |x, y| Hand::CARD_ORDER[x[0]] <=> Hand::CARD_ORDER[y[0]] }
    h[:values][:consecutive] = sorted_cards.slice_when { |prev, cur|
      Hand::CARD_ORDER[cur[0]] != Hand::CARD_ORDER[prev[0]] + 1 }.map(&:size).max
    h[:values][:highest] = sorted_cards.last[0]
    h[:values][:lowest] = sorted_cards.first[0]
    sorted_cards.each do |card|
      s_list = h[:suits][:list][card[1]].to_a
      s_list << card
      h[:suits][:list][card[1]] = s_list

      v_list = h[:values][:list][card[0]].to_a
      v_list << card
      h[:values][:list][card[0]] = v_list
    end
    h[:suits][:max] = h[:suits][:list].keys.map { |x| h[:suits][:list][x].size }.sort_by { |x| x } .reverse
    highest_values = h[:values][:list].keys.map { |x| [h[:values][:list][x].size, x] }.sort { |x, y| x[0] <=> y[0] }.reverse
    h[:values][:max] = highest_values.collect { |x| x[0] }
    h[:values][:highest_max_card] = highest_values.collect { |x| x[1] }
    h
  end

  # Check if hand matches rules for a specific rank
  def match_rules(rules_h)
    data = hand_data
    suits = true
    consecutive = true
    highest = true
    values = true
    card = true
    if rules_h[:suits]
      suits = data[:suits][:max].size.eql?(rules_h[:suits])
    end
    if rules_h[:consecutive]
      consecutive = data[:values][:consecutive].eql?(rules_h[:consecutive])
    end
    if rules_h[:highest]
      highest = data[:values][:highest].eql?(rules_h[:highest])
    end
    if rules_h[:values]
      values = data[:values][:max].first(rules_h[:values].size).eql?(rules_h[:values])
    end
    if rules_h[:card]
      card = data[:values][:highest]
    end
    if rules_h[:highest_max_card]
      card = data[:values][:highest_max_card]
    end
    suits && consecutive && highest && values && card
  end
end
