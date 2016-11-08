class UsersController < ApplicationController
  before_action :signed_in_user, only: :show
  def index
    @users = User.alphabet.paginate page: params[:page],
      per_page: Settings.number_pagin
  end

  def show
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:warning] = t :user_not_found
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      flash[:success] = t :welcome
      redirect_to @user
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
