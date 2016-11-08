class Admin::UsersController < ApplicationController
  before_action :verify_admin, only: [:destroy, :update]
  before_action :signed_in_user, only: :index
  before_action :load_user, only: [:destroy, :update, :edit]

  def index
    @users = User.alphabet.paginate page: params[:page],
      per_page: Settings.number_pagin
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t :admin_updated_user
      redirect_to admin_users_path
    else
      flash[:danger] = t :admin_cant_update_user
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t :admin_deleted_user
    else
      flash[:danger] = t :admin_cant_delete_user
    end
    redirect_to admin_users_path
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit :is_admin
  end
end
