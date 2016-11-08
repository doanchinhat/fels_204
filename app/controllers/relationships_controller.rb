class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    verify_user
    current_user.follow @user
    @count_followers = @user.followers.size
    respond_activities
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    verify_user
    current_user.unfollow @user
    @count_followers = @user.followers.size

    respond_activities
  end

  private
  def verify_user
    unless @user
      flash[:danger] = t :user_not_found
      redirect_to root_url
    end
  end

  def respond_activities
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
