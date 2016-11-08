class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def load_users
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "not_found"
      redirect_to root_url
    end
  end
end
