class Admin::CategoriesController < ApplicationController
  before_action :find_category, only: [:destroy, :update, :edit]
  before_action :verify_admin, only: [:destroy, :create, :update]
  before_action :signed_in_user, only: :index

  def index
    @categories = Category.alphabet.paginate page: params[:page] ,
      per_page: Settings.number_pagin
  end

 def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t :create_category_success
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t :update_category_success
      redirect_to admin_categories_path
    else
      flash[:danger] = t :update_category_fail
      render :edit
    end
  end

  def destroy
    if @category.words.present? && @category.lessons.present?
      flash[:danger] = t :del_cate_err
    else
      if @category.destroy
        flash[:success] = t :del_cate_suc
      else
        flash[:alert] = t :del_cate_err
      end
      redirect_to admin_categories_path
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
