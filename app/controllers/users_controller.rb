class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :check_user, only: [:edit, :update]
  
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
   @following_users = @user.following_users
   @follower_users = @user.follower_users
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      flash[:success] = "保存しました。"
      redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      # flash[:danger] = '保存に失敗しました。'
      render 'edit'
    end
  end
  

  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile)
  end

  def set_user
    @user = User.find(session[:user_id])
  end

  def check_user
    redirect_to root_path if params[:id] != session[:user_id].to_s
  end
end
