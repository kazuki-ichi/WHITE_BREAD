class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @white_bread_store = WhiteBreadStore.find(params[:white_bread_store_id])
    current_user.favorites.create(white_bread_store: @white_bread_store)
    redirect_to @white_bread_store, notice: '店舗をお気に入りしました！'
  end

  def destroy
    @white_bread_store = WhiteBreadStore.find(params[:white_bread_store_id])
    current_user.favorites.find_by(white_bread_store: @white_bread_store).destroy
    redirect_to @white_bread_store, notice: '店舗のお気に入りを解除しました。'
  end

end
