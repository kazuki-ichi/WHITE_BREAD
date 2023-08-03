# spec/models/white_bread_store_spec.rb

require 'rails_helper'

RSpec.describe WhiteBreadStore, type: :model do
  let(:user) { create(:user) }

  describe 'バリデーション' do
    it '店舗名が空欄の場合は無効であること' do
      white_bread_store = WhiteBreadStore.new(name: '', start_time: Time.current, end_time: Time.current + 1.hour, price: 500, address: '東京都渋谷区', detail: '美味しい白パン屋さん', user: user)
      expect(white_bread_store).to be_invalid
      expect(white_bread_store.errors[:name]).to include('を入力してください')
    end

    it '営業開始時間が空欄の場合は無効であること' do
      white_bread_store = WhiteBreadStore.new(name: 'パン屋さん', start_time: nil, end_time: Time.current + 1.hour, price: 500, address: '東京都渋谷区', detail: '美味しい白パン屋さん', user: user)
      expect(white_bread_store).to be_invalid
      expect(white_bread_store.errors[:start_time]).to include('を入力してください')
    end

    it '営業終了時間が空欄の場合は無効であること' do
      white_bread_store = WhiteBreadStore.new(name: 'パン屋さん', start_time: Time.current, end_time: nil, price: 500, address: '東京都渋谷区', detail: '美味しい白パン屋さん', user: user)
      expect(white_bread_store).to be_invalid
      expect(white_bread_store.errors[:end_time]).to include('を入力してください')
    end

    it '営業終了時間が営業開始時間より前の場合は無効であること' do
      white_bread_store = WhiteBreadStore.new(name: 'パン屋さん', start_time: Time.current, end_time: Time.current - 1.hour, price: 500, address: '東京都渋谷区', detail: '美味しい白パン屋さん', user: user)
      expect(white_bread_store).to be_invalid
      expect(white_bread_store.errors[:end_time]).to include('は営業開始時間より後に設定してください')
    end

    it '1斤の料金が1未満の場合は無効であること' do
      white_bread_store = WhiteBreadStore.new(name: 'パン屋さん', start_time: Time.current, end_time: Time.current + 1.hour, price: 0, address: '東京都渋谷区', detail: '美味しい白パン屋さん', user: user)
      expect(white_bread_store).to be_invalid
      expect(white_bread_store.errors[:price]).to include('は1より大きい値にしてください')
    end
  end
end
