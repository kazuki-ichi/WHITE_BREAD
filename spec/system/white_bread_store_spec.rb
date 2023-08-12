require 'rails_helper'

RSpec.describe 'WhiteBreadStore', type: :system do
  describe '店舗詳細ページ' do
    let(:user) { create(:user) }
    let(:white_bread_store) { create(:white_bread_store, name: 'パン屋', favorites_count: 0, evaluations_count: 0, price: 100) }
    let!(:white_bread_store1) { create(:white_bread_store, name: 'パン屋A', favorites_count: 5, evaluations_count: 3, price: 300) }
    let!(:white_bread_store2) { create(:white_bread_store, name: 'パン屋B', favorites_count: 7, evaluations_count: 7, price: 200) }
    let!(:white_bread_store3) { create(:white_bread_store, name: 'パン屋C', favorites_count: 2, evaluations_count: 10, price: 500) }
    
    
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

    it 'お気に入りの済みの数が表示されること' do
      favorite_count = white_bread_store.favorites.count
      visit white_bread_store_path(white_bread_store)
      
      if favorite_count > 0
        expect(page).to have_content("お気に入り済み: #{favorite_count}")
      else
        expect(page).not_to have_content("お気に入り済み:")
      end
    end

    it 'コメントの合計数が表示されること' do
      comment_count = white_bread_store.evaluations.where.not(comment: nil).count
      visit white_bread_store_path(white_bread_store)

      if comment_count > 0
        expect(page).to have_content("コメント数: #{comment_count}")
      else
        expect(page).not_to have_content("コメント数:")
      end
    end

    it '詳細ボタンをクリックして店舗詳細ページに遷移すること' do
      visit white_bread_store_path(white_bread_store)
      expect(current_path).to eq(white_bread_store_path(white_bread_store))
    end

    it 'お気に入り数が多い順をクリックしたら並び替え表示すること' do
      visit white_bread_stores_path

      click_link('お気に入り数が多い順')
      expect(page).to have_current_path(white_bread_stores_path(order: 'favorites'))
      store_names = page.all('.product-card h5').map(&:text)
      expect(store_names).to eq(['パン屋B', 'パン屋A', 'パン屋C', 'パン屋'])
    end

    it 'コメントが多い順をクリックしたら並び替え表示すること' do
      visit white_bread_stores_path

      click_link('コメントが多い順')
      expect(page).to have_current_path(white_bread_stores_path(order: 'comments'))
      store_names = page.all('.product-card h5').map(&:text)
      expect(store_names).to eq(['パン屋C', 'パン屋B', 'パン屋A', 'パン屋'])
    end

    it '価格高い順をクリックしたら並び替え表示すること' do
      visit white_bread_stores_path

      click_link('価格が高い順')
      expect(page).to have_current_path(white_bread_stores_path(order: 'price_desc'))
      store_names = page.all('.product-card h5').map(&:text)
      expect(store_names).to eq([ 'パン屋C', 'パン屋A', 'パン屋B','パン屋'])
    end

    it '価格安い順をクリックしたら並び替え表示すること' do
      visit white_bread_stores_path

      click_link('価格が安い順')
      expect(page).to have_current_path(white_bread_stores_path(order: 'price_asc'))
      store_names = page.all('.product-card h5').map(&:text)
      expect(store_names).to eq(['パン屋', 'パン屋B', 'パン屋A', 'パン屋C'])
    end

    it '新しい順に並び替えること' do
      visit white_bread_stores_path

      click_link('新しい順')
      expect(page).to have_current_path(white_bread_stores_path(order: 'recent'))
      store_names = page.all('.product-card h5').map(&:text)
      expect(store_names).to eq(['パン屋', 'パン屋C', 'パン屋B', 'パン屋A'])
    end
  end
end
