class Admin::CategoriesController < ApplicationController
  before_action :find_category, only: :destroy
  before_action :verify_admin, only: :destroy
  before_action :signed_in_user, only: :index

  def index
    @categories = Category.alphabet.paginate page: params[:page] ,
      per_page: Settings.number_pagin
  end

  def destroy
    if @category.destroy
      flash[:success] = t :del_cate_suc
    else
      flash[:alert] = t :del_cate_err
    end
    redirect_to admin_categories_path
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      redirect_to admin_categories_path
      flash[:danger] = t :category_not_found
    end
  end

  def category_params
    params.require(:category).permit :name
  end
end
