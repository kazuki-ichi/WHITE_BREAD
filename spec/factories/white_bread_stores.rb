FactoryBot.define do
    factory :white_bread_store do
      name { "パン屋さん" }
      start_time { Time.current }
      end_time { Time.current + 1.hour }
      price { 500 }
      address { "東京都渋谷区" }
      detail { "美味しい白パン屋さん" }
      association :user, factory: :user
    end
  end
