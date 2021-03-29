FactoryBot.define do
  factory :hand do
    number { rand(1000) }
    card_list { '7D 2S 5D 3S AC' }
    player
    round
  end
end