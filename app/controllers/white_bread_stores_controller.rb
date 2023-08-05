class WhiteBreadStoresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:query].present?
      @white_bread_stores = WhiteBreadStore.where("name LIKE ? OR address LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @white_bread_stores = WhiteBreadStore.all
    end
  end

  def own
    @user = current_user
    @white_bread_stores = @user.white_bread_stores
  end

  def new
    @white_bread_store = WhiteBreadStore.new
  end

  def create
    @white_bread_store = WhiteBreadStore.new(params.require(:white_bread_store).permit(:name, :detail, :price, :image, :user_id, :start_time, :end_time, :address, :latitude, :longitude))
    if @white_bread_store.save
      flash[:notice] = "店舗を投稿しました。"
      redirect_to :white_bread_stores_own
    else
      render "new"
    end
  end

  def show
    @white_bread_store = WhiteBreadStore.find(params[:id])
    @evaluation = Evaluation.new
  end

  def destroy
    @white_bread_store = WhiteBreadStore.find(params[:id])
    @white_bread_store.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to :white_bread_stores_own
  end

  def edit
    @white_bread_store = WhiteBreadStore.find(params[:id])
  end

  def update
    @white_bread_store = WhiteBreadStore.find(params[:id])
    if @white_bread_store.update(params.require(:white_bread_store).permit(:name, :detail, :price, :image, :user_id, :start_time, :end_time, :address, :latitude, :longitude))
      flash[:notice] = "店舗を編集しました。"
      redirect_to :white_bread_stores_own
    else
      render "edit"
    end
  end

  def favorite
    @white_bread_store = WhiteBreadStore.find(params[:id])

    unless current_user.favorite_white_bread_stores.include?(@white_bread_store)
      current_user.favorite_white_bread_stores << @white_bread_store
      flash[:notice] = "お気に入りに追加しました。"
    else
      flash[:notice] = "すでにお気に入りに追加されています。"
    end

    redirect_to @white_bread_store
  end

  def unfavorite
    @white_bread_store = WhiteBreadStore.find(params[:id])

    if current_user.favorite_white_bread_stores.include?(@white_bread_store)
      current_user.favorite_white_bread_stores.delete(@white_bread_store)
      flash[:notice] = "お気に入りから削除しました。"
    else
      flash[:notice] = "お気に入りに含まれていません。"
    end

    redirect_to @white_bread_store
  end
end
