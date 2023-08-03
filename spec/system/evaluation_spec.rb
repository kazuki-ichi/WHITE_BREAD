require 'rails_helper'

RSpec.describe 'Evaluation', type: :system do
  let(:white_bread_store) { FactoryBot.create(:white_bread_store) }
  let(:user) { FactoryBot.create(:user) }
  let(:evaluation) { FactoryBot.create(:evaluation, white_bread_store: white_bread_store, user: user) }

  describe '評価の編集' do
    
    before do
        # テストユーザーでログイン
        sign_in user
        visit edit_evaluation_path(evaluation)
      end

    it '評価を編集できること' do

      visit edit_evaluation_path(evaluation)
      # 甘さの評価を選択するコード
      choose 'evaluation_sweetness_5', allow_label_click: true # とても甘い

      # 食感の評価を選択するコード
      choose 'evaluation_texture_4', allow_label_click: true # 柔らかい

      # コメントを入力するコード
      fill_in 'evaluation_comment', with: 'とても美味しかったです！'

      # 更新ボタンをクリックするコード
      click_button '更新'

      # 編集が成功したかを確認するコード
      expect(page).to have_content('評価が更新されました。')
    end
  end
end
