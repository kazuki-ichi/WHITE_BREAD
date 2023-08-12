FactoryBot.define do
  factory :white_bread_store do
    name { "パン屋さん" }
    start_time { Time.current }
    end_time { Time.current + 1.hour }
    price { 500 }
    address { "東京都渋谷区" }
    detail { "美味しい白パン屋さん" }
    association :user, factory: :user
    
    transient do
      favorites_count { 0 }
      evaluations_count { 0 }
    end

    after(:create) do |white_bread_store, evaluator|
      create_list(:favorite, evaluator.favorites_count, white_bread_store: white_bread_store)
      create_list(:evaluation, evaluator.evaluations_count, white_bread_store: white_bread_store)
    end

  end
end
