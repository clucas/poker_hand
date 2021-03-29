FactoryBot.define do
  factory :round do
    number { rand(1000) }
    game
  end
end