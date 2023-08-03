FactoryBot.define do
    factory :favorite do
      association :user, factory: :user
      association :white_bread_store, factory: :white_bread_store
    end
  end
