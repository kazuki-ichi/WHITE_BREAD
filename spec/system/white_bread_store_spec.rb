require 'rails_helper'

RSpec.describe 'WhiteBreadStore', type: :system do
  describe '店舗詳細ページ' do
    let(:user) { create(:user) }
    let(:white_bread_store) { create(:white_bread_store) }

    before do
      sign_in user
      visit white_bread_store_path(white_bread_store)
    end

    it '店舗名が表示されること' do
      sign_in user
      expect(page).to have_content(white_bread_store.name)
    end

    it '価格が表示されること' do
      expect(page).to have_content("#{white_bread_store.price}円")
    end

    it '営業時間が表示されること' do
      expect(page).to have_content("#{white_bread_store.start_time.strftime('%H:%M')}〜#{white_bread_store.end_time.strftime('%H:%M')}")
    end

    it '住所が表示されること' do
      expect(page).to have_content(white_bread_store.address)
    end

    it '評価が表示されること' do
      expect(page).to have_content('評価一覧')
      expect(page).to have_content('投稿がありません。')
    end
  end
end
