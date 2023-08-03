class UsersController < ApplicationController
  def create
    @user = User.new(name: params[:name])
    if params[:image]
      @user.icon_path = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.icon_path}", image.read)
    end
  end

  def profileedit
    @user = current_user
  end

  def update
    @user = current_user
    if params[:user][:remove_avatar] == "1"
      @user.avatar.purge
    end

    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました。"
      redirect_to users_profileedit_path
    else
      render "profileedit", locals: { user: @user }
    end
  end

  def own
    @user = current_user
    @white_bread_stores = @user.favorites.map(&:white_bread_store)
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar)
  end

end
