class Round < ApplicationRecord
  belongs_to :game, counter_cache: true
  has_many :hands
  has_many :players, through: :hands
  has_one :win, dependent: :nullify

  validates :number, presence: true
  validates :game, presence: true

  # Find winning hand by rand and highest card
  def find_winning_hand
    results = self.hands.collect { |x| [x.id, x.rank] }.sort { |x, y|
      [Hand::RANKS[x.last[0]][:rank], Hand::CARD_ORDER[x.last.last]] <=> [Hand::RANKS[y.last[0]][:rank], Hand::CARD_ORDER[y.last.last]] }
    Win.find_or_create_by!(round: self, hand_id: results.last.first, status: true, rank: results.last.last.first)
  end
end
