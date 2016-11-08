class FollowingController < ApplicationController
  before_action :signed_in_user, only: :index
  before_action :load_users

  def index
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.number_pagin
  end
end
