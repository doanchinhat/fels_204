class CategoriesController < ApplicationController
  before_action :signed_in_user, only: :index

  def index
    @categories = Category.alphabet.paginate page: params[:page], per_page:
      Settings.number_pagin
    @lesson = Lesson.new
  end

  private
  def find_category
    @category = Category.find_by id: params[:id]
  end

  def category_params
    params.require(:category).permit :name
  end
end
