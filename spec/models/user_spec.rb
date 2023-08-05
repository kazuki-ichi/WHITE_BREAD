require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '名前が存在しなければ無効であること' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'メールアドレスが存在しなければ無効であること' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it '正しいフォーマットのメールアドレスでなければ無効であること' do
      user = build(:user, email: 'invalid_email')
      expect(user).not_to be_valid
    end

    it 'パスワードが存在しなければ無効であること' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'パスワードが6文字未満の場合は無効であること' do
      user = build(:user, password: '12345')
      expect(user).not_to be_valid
    end

    it 'パスワードが6文字以上の場合は有効であること' do
      user = build(:user, password: '123456')
      expect(user).to be_valid
    end
  end

  describe '関連付け' do
    it 'Evaluationsと関連付けられていること' do
      expect(User.reflect_on_association(:evaluations).macro).to eq :has_many
    end

    it 'WhiteBreadStoresと関連付けられていること' do
      expect(User.reflect_on_association(:white_bread_stores).macro).to eq :has_many
    end

    it 'Favoritesと関連付けられていること' do
      expect(User.reflect_on_association(:favorites).macro).to eq :has_many
    end

    it 'FavoriteWhiteBreadStoresと関連付けられていること' do
      expect(User.reflect_on_association(:favorite_white_bread_stores).macro).to eq :has_many
    end
  end

  describe 'メソッド' do
    it 'default_imageメソッドが正しく動作していること' do
      user = create(:user, avatar: nil)
      user.default_image
      expect(user.avatar).to be_attached
    end

    it 'favoriteメソッドが正しく動作していること' do
      white_bread_store = create(:white_bread_store)
      user = create(:user)
      favorite = user.favorite(white_bread_store)
      expect(favorite).to be_valid
    end

    it 'unfavoriteメソッドが正しく動作していること' do
      white_bread_store = create(:white_bread_store)
      user = create(:user)
      user.favorite(white_bread_store)
      expect { user.unfavorite(white_bread_store) }.to change { Favorite.count }.by(-1)
    end

    it 'favorite?メソッドが正しく動作していること' do
      white_bread_store = create(:white_bread_store)
      user = create(:user)
      user.favorite(white_bread_store)
      expect(user.favorite?(white_bread_store)).to be_truthy
    end
  end
end
