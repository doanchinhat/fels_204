class CategoriesController < ApplicationController
  before_action :signed_in_user, only: :index

  def index
    @categories = Category.alphabet.paginate page: params[:page], per_page:
      Settings.number_pagin
  end
end
