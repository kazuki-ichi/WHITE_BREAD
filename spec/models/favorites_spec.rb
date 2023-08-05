require 'rails_helper'

RSpec.describe Favorite, type: :model do
   describe 'バリデーション' do
    it '同じユーザーと白パン屋の組み合わせが一意であること' do
     
    end
  end

  describe '関連付け' do
    it 'Userと関連付けられていること' do
      expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'WhiteBreadStoreと関連付けられていること' do
      expect(Favorite.reflect_on_association(:white_bread_store).macro).to eq :belongs_to
    end
  end
end
