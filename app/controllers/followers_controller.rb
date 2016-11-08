class FollowersController < ApplicationController
  before_action :signed_in_user, only: :index
  before_action :load_users

  def index
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.number_pagin
  end
end
