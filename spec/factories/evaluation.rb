FactoryBot.define do
    factory :evaluation do
      sweetness { 3 }
      texture { 4 }
      comment { 'とても美味しいパンでした！' }
      white_bread_store
      user
    end
  end
