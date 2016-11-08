class Admin::WordsController < ApplicationController
  before_action :load_word, except: [:index, :new, :create]
  before_action :verify_admin, only: [:destroy, :create, :update]
  before_action :signed_in_user, only: :index
  before_action :load_category, only:[:edit, :update]

  def index
    @words = Word.includes(:answers).alphabet
      .paginate page: params[:page], per_page: Settings.number_pagin
  end

  def new
    @categories = Category.all.alphabet
    @word = Word.new
    @word.answers.new
  end

  def create
    @categories = Category.all.alphabet
    @word = Word.new word_params
    if @word.save
      flash[:success] = t :create_word_success
      redirect_to admin_words_path
    else
      render :new
    end
  end

  def edit
    @categories = Category.all.alphabet
  end

  def update
    @categories = Category.all.alphabet
    if @word.update_attributes word_params
      flash[:success] = t :update_word_success
      redirect_to admin_words_path
    else
      render :edit
    end
  end

  def destroy
    if @word.results.present?
      flash[:danger] = t :delete_word_fail
    else
      if @word.destroy
        flash[:success] = t :delete_word_success
      else
        flash[:danger] = t :delete_word_fail
      end
    end
    redirect_to admin_words_path
  end

  private
  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t :not_found
      redirect_to admin_categories_path
    end
  end

  def load_category
    category = Category.find_by id: params[:category_id]
  end

  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
