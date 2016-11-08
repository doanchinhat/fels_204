class WordsController < ApplicationController
  before_action :signed_in_user, only: :index

  def index
    @categories = Category.all
    @words_temp = if params[:condition] && params[:condition] == t(:all).downcase
      Word.includes(:answers).filter_category(params[:category_id])
    elsif params[:condition]
      Word.includes(:answers).filter_category(params[:category_id])
        .send(params[:condition], current_user.id)
    else
      Word.includes(:answers).search_by params[:search_word].to_s.titleize
    end.alphabet
    @words = @words_temp.paginate page: params[:page],
      per_page: Settings.number_pagin
  end
end
