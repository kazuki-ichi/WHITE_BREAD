require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'ログイン' do
    it 'ログインページにアクセスできること' do
      visit new_user_session_path
      expect(page).to have_content('ログイン')
    end
  end

  describe '新規登録' do
    it '新規登録ページにアクセスできること' do
      visit new_user_registration_path
      expect(page).to have_content('新規登録')
    end
  end
end
