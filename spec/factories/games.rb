FactoryBot.define do
  factory :game do
    sequence(:name) { |n| "game_#{n} #{rand(1000)}" }
  end
end