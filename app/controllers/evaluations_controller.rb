class EvaluationsController < ApplicationController
  def new
    @white_bread_store = WhiteBreadStore.find(params[:id])
    @evaluation = Evaluation.new
  end

  def create
    @white_bread_store = WhiteBreadStore.find(params[:evaluation][:white_bread_store_id])
    @evaluation = current_user.evaluations.new(evaluation_params)
    @evaluation.white_bread_store = @white_bread_store

    if @evaluation.save
      redirect_to @white_bread_store, notice: "評価が成功しました。"
    else
      render "white_bread_stores/show"
    end
  end

  def destroy
    @evaluation = Evaluation.find(params[:id])
    @white_bread_store = @evaluation.white_bread_store

    if current_user == @evaluation.user && @evaluation.destroy
      redirect_to @white_bread_store, notice: "評価を削除しました。"
    else
      redirect_to @white_bread_store, alert: "評価の削除に失敗しました。"
    end
  end

  def edit
    @evaluation = Evaluation.find(params[:id])
  end

  def update
    @evaluation = Evaluation.find(params[:id])

    if @evaluation.update(evaluation_params)
      redirect_to @evaluation.white_bread_store, notice: '評価が更新されました。'
    else
      flash[:alert] = '評価の更新に失敗しました。'
      render "edit"
    end
  end

  private

  def evaluation_params
    params.require(:evaluation).permit(:taste, :sweetness, :comment, :texture, :user_id, :white_bread_store_id)
  end
end
