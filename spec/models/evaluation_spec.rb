require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  let(:user) { build(:user) } # buildを使用する
  let(:white_bread_store) { create(:white_bread_store) }

  describe '関連付け' do
    it 'WhiteBreadStoreと関連付けられていること' do
      evaluation = Evaluation.new(user: user, sweetness: 3, texture: 3, white_bread_store: white_bread_store)
      expect(evaluation).to respond_to(:white_bread_store)
    end

    it 'Userと関連付けられていること' do
      evaluation = Evaluation.new(white_bread_store: white_bread_store, sweetness: 3, texture: 3, user: user)
      expect(evaluation).to respond_to(:user)
    end
  end
end
