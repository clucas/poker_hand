FactoryBot.define do
  factory :player do
    name { "player #{rand(1000)}" }
    game
  end
end