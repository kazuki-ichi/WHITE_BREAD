require 'rails_helper'

RSpec.describe 'Evaluation', type: :system do
  let(:white_bread_store) { FactoryBot.create(:white_bread_store) }
  let(:user) { FactoryBot.create(:user) }
  let(:evaluation) { FactoryBot.create(:evaluation, white_bread_store: white_bread_store, user: user) }

  describe '評価の編集' do
    before do
        sign_in user
        visit edit_evaluation_path(evaluation)
      end

      it '評価を編集できること' do
        choose 'evaluation_sweetness_5', allow_label_click: true
        choose 'evaluation_texture_4', allow_label_click: true
        choose 'evaluation_taste_3', allow_label_click: true
        fill_in 'evaluation_comment', with: 'とても美味しかったです！'
        click_button '更新'
        expect(page).to have_content('評価が更新されました。')
      end
  end
end
